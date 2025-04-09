import Foundation
import Vision
import VisionKit
import onnxruntime_objc  // ✅ Add this

@objc(VisionCameraMovenetLitePlugin)
public class VisionCameraMovenetLitePlugin: NSObject, FrameProcessorPlugin {
  var session: ORTSession?

  override init() {
    super.init()
    do {
      let env = try ORTEnv(loggingLevel: .warning)
      let options = ORTSessionOptions()

      // ✅ Ensure the .onnx model is bundled in Xcode
      let modelPath = Bundle.main.path(forResource: "movenet_lightning", ofType: "onnx")!
      session = try ORTSession(env: env, modelPath: modelPath, sessionOptions: options)
    } catch {
      print("❌ Failed to init ONNX: \(error)")
    }
  }

  public func callback(_ frame: Frame) -> Any? {
    guard let session = session else { return nil }

    // ✅ Process pixel buffer -> input tensor here
    // For now, just a placeholder — I’ll help you write this
    // let input = makeORTValue(from: frame)

    // Run ONNX
    do {
      let outputs = try session.run(withInputs: [:], outputNames: nil, runOptions: nil)
      // Parse keypoints from outputs and return to JS
      return ["keypoints": "TODO"]
    } catch {
      print("❌ Inference failed: \(error)")
      return nil
    }
  }
}
