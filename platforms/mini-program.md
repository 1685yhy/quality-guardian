# Capturing WeChat Mini Program Materials

Use this guide when Quality Guardian needs to evaluate a WeChat mini program.

## Method 1: WeChat DevTools (Recommended)

1. Open your mini program project in WeChat DevTools (微信开发者工具)
2. Click the "Preview" (预览) button to load your mini program
3. For each key page: use the screenshot button (or Cmd+Shift+S / Ctrl+Shift+S) to capture
4. For core user flows: use the recording feature to capture the full interaction
5. Save all captures to a folder and provide the paths to Quality Guardian

### Key Pages to Capture
- Home/first screen
- Core feature pages (at least 3-5)
- Empty states (first-time user view)
- Error states (network error, permission denied)
- Loading states
- Payment/checkout flow (if applicable)
- Settings/profile page

### Recording Flow
Record these user journeys (30-60 seconds each):
1. New user onboarding/first experience
2. Primary task completion (e.g., place an order, perform a reading)
3. Error recovery (what happens when things go wrong)

## Method 2: Real Device (真机调试)

1. In WeChat DevTools, click "Real Device Debugging" (真机调试)
2. Scan the QR code with your phone
3. On your phone, navigate through key pages and take screenshots
4. Use your phone's screen recording feature for core flows

## Method 3: Phone Screen Recording (No DevTools)

1. Open the published mini program on your phone
2. Use your phone's built-in screen recording
3. Navigate through all key pages and flows
4. Transfer the recording to your computer

## What NOT to Do

- Do NOT send WXML/WXSS source code as "evidence"
- Do NOT send the project file tree as "proof of structure"
- Do NOT describe what the code does — show what the user sees
