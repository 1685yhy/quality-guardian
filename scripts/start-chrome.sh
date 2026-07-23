#!/bin/bash
# Quality Guardian — Chrome auto-start script
# Searches for a working Chromium and starts it with DevTools Protocol on port 9222

PORT=${1:-9222}
PROFILE_DIR=${2:-/tmp/qg-chrome-profile}
mkdir -p "$PROFILE_DIR"

# Priority-ordered list of known-good Chromium paths
PATHS=(
  # Playwright-bundled Chromiums (usually work in WSL/Docker)
  ~/.cache/ms-playwright/chromium-*/chrome-linux64/chrome
  # System paths
  /usr/bin/google-chrome-stable
  /usr/bin/google-chrome
  /usr/bin/chromium-browser
  /usr/bin/chromium
  # macOS
  "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
  # Windows (WSL)
  "/mnt/c/Program Files/Google/Chrome/Application/chrome.exe"
  "/mnt/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe"
)

for pattern in "${PATHS[@]}"; do
  # Expand glob patterns
  for path in $pattern; do
    if [ -x "$path" ] || [ -f "$path" ]; then
      echo "Found: $path"
      "$path" \
        --remote-debugging-port="$PORT" \
        --no-sandbox \
        --headless=new \
        --disable-gpu \
        --disable-software-rasterizer \
        --no-first-run \
        --no-default-browser-check \
        --user-data-dir="$PROFILE_DIR" \
        about:blank \
        > /tmp/qg-chrome.log 2>&1 &
      PID=$!
      echo "Started Chrome (PID: $PID) on port $PORT"
      
      # Wait for Chrome to be ready
      for i in $(seq 1 15); do
        sleep 1
        if curl -s http://localhost:$PORT/json/version > /dev/null 2>&1; then
          echo "Chrome ready on port $PORT"
          exit 0
        fi
      done
      echo "Chrome started but not responding on port $PORT"
      exit 1
    fi
  done
done

echo "No Chrome/Chromium found. Searched: ${PATHS[*]}"
echo "Install Chromium: sudo apt install -y chromium-browser"
echo "Or install Playwright: npx playwright install chromium"
exit 1
