#import <React/RCTBridgeModule.h>
#import <VisionCamera/FrameProcessorPluginRegistry.h>
#import "squat_pro-Swift.h" // Replace with your project name-Swift.h

@implementation VisionCameraMovenetLite
RCT_EXPORT_MODULE()

+ (void)load {
  FrameProcessorPluginRegistry.addFrameProcessorPlugin("detectPose", VisionCameraMovenetLiteFrameProcessor.callback);
}

@end
