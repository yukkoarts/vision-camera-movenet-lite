import { Frame } from 'react-native-vision-camera';
import { Worklets } from 'react-native-worklets-core';

/**
 * Run on the native side and return a pose.
 * You must install this plugin natively for this to work.
 */
export const scanPoses = Worklets.createRunOnUI((frame: Frame) => {
  'worklet';
  // This function is replaced by native implementation
  return {};
});
