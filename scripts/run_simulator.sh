#!/bin/bash

# --- CONFIGURATION ---
# Replace these with your actual project details!
PROJECT_NAME="NavigationRouterDemo.xcodeproj"     # If using a workspace, use YourApp.xcworkspace and change -project to -workspace below
SCHEME_NAME="NavigationRouterDemo"                # Usually the same name as your app
BUNDLE_ID="emperor.com.NavigationRouterDemo"  # Found in your project settings
# ---------------------

echo "🚀 Starting Build Process..."

# 1. Find a booted simulator
# This grabs the UUID of the first currently booted simulator
DEVICE_ID=$(xcrun simctl list devices | grep "(Booted)" | head -1 | grep -oE '[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12}')

if [ -z "$DEVICE_ID" ]; then
    echo "⚠️ No simulator booted. Booting default simulator..."
    # You can change "iPhone 17 Pro Max" to whichever device you prefer
    xcrun simctl boot "iPhone 17 Pro Max"
    DEVICE_ID=$(xcrun simctl list devices | grep "(Booted)" | head -1 | grep -oE '[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12}')
fi

echo "📱 Using Simulator ID: $DEVICE_ID"

# 2. Build the project
echo "🔨 Building $SCHEME_NAME..."
xcodebuild -project "$PROJECT_NAME" \
           -scheme "$SCHEME_NAME" \
           -destination "id=$DEVICE_ID" \
           -configuration Debug \
           -derivedDataPath ./build \
           build | xcpretty # Note: You can remove '| xcpretty' if you don't have it installed, but it makes logs cleaner.

# Check if the build command was successful
if [ ${PIPESTATUS[0]} -ne 0 ]; then
    echo "❌ Build failed. Please check the terminal errors."
    exit 1
fi

# 3. Locate the compiled .app file in the Derived Data folder
APP_PATH=$(find ./build/Build/Products/Debug-iphonesimulator -name "*.app" | head -1)

if [ -z "$APP_PATH" ]; then
    echo "❌ Could not find the compiled .app file. Build may have failed."
    exit 1
fi

# 4. Install and Launch on the Simulator
echo "📲 Installing app to simulator..."
xcrun simctl install "$DEVICE_ID" "$APP_PATH"

echo "✨ Launching $BUNDLE_ID..."
xcrun simctl launch "$DEVICE_ID" "$BUNDLE_ID"

echo "✅ Success! App is running on the simulator."