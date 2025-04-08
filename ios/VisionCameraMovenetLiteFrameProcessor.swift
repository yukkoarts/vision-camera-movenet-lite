import Foundation
import Vision
import CoreML
import VisionCamera

@objc(VisionCameraMovenetLiteFrameProcessor)
public class VisionCameraMovenetLiteFrameProcessor: NSObject, FrameProcessorPlugin {
  public static func callback(_ frame: Frame!, withArguments arguments: [Any]!) -> Any! {
    // Example dummy pose
    return [
      "keypoints": [
        ["name": "left_knee", "x": 100, "y": 300],
        ["name": "right_knee", "x": 200, "y": 300],
        // add more fake keypoints if needed
      ]
    ]
  }
}
