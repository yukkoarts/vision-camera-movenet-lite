// vision-camera-movenet-lite/index.ts
import { Frame } from 'react-native-vision-camera';

/**
 * Calls the native frame processor plugin registered as 'detectPose'
 */
export function detectPose(frame: Frame): any {
  'worklet';
  return __detectPose(frame);
}
