# Capturing Native Mobile App Materials

Use this guide when Quality Guardian needs to evaluate an iOS or Android app.

## iOS

### Method 1: Xcode Simulator (Recommended)
1. Build and run your app in Xcode Simulator
2. Use Cmd+S to capture screenshots
3. Use `xcrun simctl io booted recordVideo recording.mp4` for screen recordings
4. Navigate through all key pages and flows

### Method 2: TestFlight
1. Install the TestFlight build on a real device
2. Take screenshots (physical buttons or AssistiveTouch)
3. Use screen recording from Control Center

## Android

### Method 1: Android Emulator (Recommended)
1. Build and run in Android Studio Emulator
2. Use the camera icon in the emulator toolbar for screenshots
3. Use `adb shell screenrecord /sdcard/recording.mp4` for recordings

### Method 2: Real Device
1. Install the debug APK on a real device
2. Take screenshots and screen recordings natively

## Key Screens to Capture
- Launch/splash screen
- Onboarding flow
- Home/dashboard
- Core feature pages (3-5)
- Empty states
- Error states (network offline, permission denied)
- Settings
- Account/profile

## What NOT to Do
- Do NOT send Swift/Kotlin source code
- Do NOT send Xcode/Android Studio project structure
- Do NOT describe implementations — show the running app
