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
  // For now, return mock keypoints
  return @{
    @"keypoints": @[
      @{ @"name": @"left_knee", @"x": @150, @"y": @300, @"score": @0.9 },
      @{ @"name": @"right_knee", @"x": @250, @"y": @300, @"score": @0.9 },
      @{ @"name": @"left_hip", @"x": @140, @"y": @250, @"score": @0.95 },
      @{ @"name": @"right_hip", @"x": @260, @"y": @250, @"score": @0.95 }
    ]
  };
}

@end

VISION_EXPORT_FRAME_PROCESSOR(VisionCameraPosePlugin, scanPoses)
