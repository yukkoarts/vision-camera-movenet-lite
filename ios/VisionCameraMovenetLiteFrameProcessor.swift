import Foundation
import CoreImage
import CoreVideo
import Vision
import onnxruntime_objc
import VisionCamera

@objc(VisionCameraMovenetLitePlugin)
public class VisionCameraMovenetLitePlugin: NSObject, FrameProcessorPlugin {
  var session: ORTSession?

  override public init() {
    super.init()

    do {
      let env = try ORTEnv(loggingLevel: .warning)
      let sessionOptions = ORTSessionOptions()

      if let modelPath = Bundle.main.path(forResource: "movenet_singlepose_lightning", ofType: "onnx") {
        session = try ORTSession(env: env, modelPath: modelPath, sessionOptions: sessionOptions)
        print("✅ MoveNet model loaded successfully")
      } else {
        print("❌ MoveNet model not found in bundle")
      }
    } catch {
      print("❌ Error initializing ONNX session: \(error)")
    }
  }

  public func callback(_ frame: Frame) -> Any? {
    guard let session = session else { return nil }

    do {
      let input = try makeORTValue(from: frame)
      let inputName = try session.inputNames().first as! String
      let outputs = try session.run(withInputs: [inputName: input], outputNames: nil, runOptions: nil)

      if let output = outputs.first?.value as? ORTValue {
        // TODO: Decode keypoints from output
        return ["result": "✅ Inference completed"]
      }
    } catch {
      print("❌ Inference failed: \(error)")
    }

    return nil
  }

  private func makeORTValue(from frame: Frame) throws -> ORTValue {
    guard let pixelBuffer = frame.pixelBuffer else {
      throw NSError(domain: "Frame Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "Missing pixel buffer"])
    }

    let width = 192
    let height = 192

    var ciImage = CIImage(cvPixelBuffer: pixelBuffer)
    let scaleX = CGFloat(width) / ciImage.extent.width
    let scaleY = CGFloat(height) / ciImage.extent.height
    ciImage = ciImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))

    let context = CIContext()
    var resizedBuffer: CVPixelBuffer?
    let attrs: [String: Any] = [
      kCVPixelBufferCGImageCompatibilityKey as String: true,
      kCVPixelBufferCGBitmapContextCompatibilityKey as String: true,
      kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA,
    ]
    CVPixelBufferCreate(kCFAllocatorDefault, width, height, kCVPixelFormatType_32BGRA, attrs as CFDictionary, &resizedBuffer)

    guard let rgbBuffer = resizedBuffer else {
      throw NSError(domain: "Preprocessing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to create RGB buffer"])
    }

    context.render(ciImage, to: rgbBuffer)

    CVPixelBufferLockBaseAddress(rgbBuffer, .readOnly)
    let baseAddress = CVPixelBufferGetBaseAddress(rgbBuffer)!
    let bytesPerRow = CVPixelBufferGetBytesPerRow(rgbBuffer)

    var inputTensor = [Float32](repeating: 0, count: width * height * 3)

    for y in 0..<height {
      for x in 0..<width {
        let pixel = baseAddress.advanced(by: y * bytesPerRow + x * 4)
        let b = Float(pixel.load(fromByteOffset: 0, as: UInt8.self)) / 255.0
        let g = Float(pixel.load(fromByteOffset: 1, as: UInt8.self)) / 255.0
        let r = Float(pixel.load(fromByteOffset: 2, as: UInt8.self)) / 255.0

        let index = (y * width + x) * 3
        inputTensor[index] = r
        inputTensor[index + 1] = g
        inputTensor[index + 2] = b
      }
    }

    CVPixelBufferUnlockBaseAddress(rgbBuffer, .readOnly)

    let shape: [NSNumber] = [1, 192, 192, 3]
    return try ORTValue(
      tensorData: Data(bytes: &inputTensor, count: inputTensor.count * MemoryLayout<Float32>.size),
      elementType: ORTTensorElementDataType.float,
      shape: shape
    )
  }
}
