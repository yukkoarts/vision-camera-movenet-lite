# vision-camera-movenet-lite

🎯 A lightweight MoveNet frame processor plugin for [`react-native-vision-camera`](https://github.com/mrousavy/react-native-vision-camera).  
Detect 17 body keypoints in real time — with blazing native speed.

---

## 📦 What It Does

- Uses [Google’s MoveNet Lightning](https://www.tensorflow.org/lite/models/pose_estimation/overview) for pose detection.
- Built as a native plugin for `react-native-vision-camera`.
- Returns a pose object `{ keypoints: [...] }` that’s easy to use in JS.
- Optimized for real-time performance — no TensorFlow.js required.

---

## 🚀 How to Install

```bash
npm install https://github.com/yukkoarts/vision-camera-movenet-lite.git
```

Then use in your frame processor:

```ts
import { scanPoses } from 'vision-camera-movenet-lite';

const pose = scanPoses(frame);
```

---

## 💡 Why I Made This

Hi, I'm Yukko — a creative tech maker behind **Squat Pro**, a squat tracking app that acts like a real-time fitness coach.  
I wanted to build something that helps people move, grow stronger, and feel proud of themselves — even if they're not into fitness (just like me when I started!).

TensorFlow was too slow. So I made this native plugin — to get real-time pose detection working smoothly in React Native.

✨ If this helps your idea grow, I’d love to know.

---

## ☕ Support My Work

If this helped you or your project, you can say thanks here:  
👉 [Buy me a coffee](https://buymeacoffee.com/dinozzstudio)

---

## 🧘‍♀️ Do Something Good With It

You don’t have to build a fitness app.  
Maybe your idea helps dancers, moms, kids, or elders.  
Whatever it is, I hope it makes someone feel seen, safe, or strong.

— Yukko 💛
