#include <jsi/jsi.h>
#include <VisionCameraFrameProcessor/FrameHostObject.h>
#include <android/log.h>

using namespace facebook;

namespace vision {
  namespace poseplugin {

    static jsi::Value scanPoses(jsi::Runtime& runtime, FrameProcessor::FrameHostObject* frame) {
      auto result = jsi::Object(runtime);
      auto keypoints = jsi::Array(runtime, 4);

      keypoints.setValueAtIndex(runtime, 0, jsi::Object(runtime)
        .setProperty(runtime, "name", jsi::String::createFromUtf8(runtime, "left_knee"))
        .setProperty(runtime, "x", 150).setProperty(runtime, "y", 300).setProperty(runtime, "score", 0.9));

      keypoints.setValueAtIndex(runtime, 1, jsi::Object(runtime)
        .setProperty(runtime, "name", jsi::String::createFromUtf8(runtime, "right_knee"))
        .setProperty(runtime, "x", 250).setProperty(runtime, "y", 300).setProperty(runtime, "score", 0.9));

      keypoints.setValueAtIndex(runtime, 2, jsi::Object(runtime)
        .setProperty(runtime, "name", jsi::String::createFromUtf8(runtime, "left_hip"))
        .setProperty(runtime, "x", 140).setProperty(runtime, "y", 250).setProperty(runtime, "score", 0.95));

      keypoints.setValueAtIndex(runtime, 3, jsi::Object(runtime)
        .setProperty(runtime, "name", jsi::String::createFromUtf8(runtime, "right_hip"))
        .setProperty(runtime, "x", 260).setProperty(runtime, "y", 250).setProperty(runtime, "score", 0.95));

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
