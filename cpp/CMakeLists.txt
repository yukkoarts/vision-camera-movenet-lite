#include <jsi/jsi.h>
#include <VisionCameraFrameProcessor/FrameHostObject.h>
#include <android/log.h>

using namespace facebook;

namespace vision {
  namespace poseplugin {

    static jsi::Value scanPoses(jsi::Runtime& runtime, FrameProcessor::FrameHostObject* frame) {
      auto result = jsi::Object(runtime);
      auto keypoints = jsi::Array(runtime, 0); // Empty array for now
      result.setProperty(runtime, "keypoints", keypoints);
      return result;
    }

    static std::unordered_map<std::string, FrameProcessor::FrameProcessorCallback> frameProcessors = {
      {"scanPoses", scanPoses}
    };

    extern "C" JNIEXPORT void install(jsi::Runtime& runtime) {
      FrameProcessor::registerFrameProcessors(runtime, frameProcessors);
    }
  }
}
