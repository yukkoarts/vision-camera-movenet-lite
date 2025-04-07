#import <VisionCamera/FrameProcessorPlugin.h>
#import <VisionCamera/Frame.h>
#import <Foundation/Foundation.h>
#import <CoreImage/CoreImage.h>
#import <Accelerate/Accelerate.h>

// Replace this with real MoveNet implementation if needed
@interface Pose : NSObject
@property(nonatomic, strong) NSDictionary *dictionary;
@end

@implementation Pose
@end

// Main Plugin
@interface VisionCameraPosePlugin : NSObject <FrameProcessorPlugin>
@end

@implementation VisionCameraPosePlugin

- (id)callback:(Frame *)frame withArguments:(NSArray *)arguments {
  // This is where pose detection would happen (native part)
  // Return empty for now – real pose data should be added here
  return @{ @"keypoints": @[] };
}

@end

VISION_EXPORT_FRAME_PROCESSOR(VisionCameraPosePlugin, scanPoses)
