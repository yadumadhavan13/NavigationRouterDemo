#!/bin/bash

# --- CONFIGURATION ---
PROJECT_NAME="NavigationRouterDemo.xcodeproj"
SCHEME_NAME="NavigationRouterDemo"
TEST_TARGET="emperor.com.NavigationRouterDemo" # ⚠️ This must match the name of your Test Target in Xcode!
# ---------------------

echo "🧪 Preparing Test Environment..."

# 1. Ensure a simulator is booted (Tests need a destination)
DEVICE_ID=$(xcrun simctl list devices | grep "(Booted)" | head -1 | grep -oE '[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12}')
if [ -z "$DEVICE_ID" ]; then
    xcrun simctl boot "iPhone 17 Pro Max"
    DEVICE_ID=$(xcrun simctl list devices | grep "(Booted)" | head -1 | grep -oE '[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12}')
fi

# 2. Find changed Swift files
CHANGED_FILES=$(git ls-files --modified --others --exclude-standard | grep '\.swift$')

TEST_FLAGS=""

if [ -z "$CHANGED_FILES" ]; then
    echo "✨ No changed files detected. Running ALL tests..."
    # Leave TEST_FLAGS empty to run the whole suite
else
    echo "🔍 Mapping changed files to tests..."
    
    while IFS= read -r file; do
        if [ -n "$file" ]; then
            # Extract just the filename without the .swift extension
            BASENAME=$(basename "$file" .swift)
            
            # Check if the file is already a test file
            if [[ "$BASENAME" == *Tests ]]; then
                echo "   👉 Adding $BASENAME"
                TEST_FLAGS="$TEST_FLAGS -only-testing:$TEST_TARGET/$BASENAME"
            else
                # Assume a corresponding test file exists and add it
                echo "   👉 Adding ${BASENAME}Tests"
                TEST_FLAGS="$TEST_FLAGS -only-testing:$TEST_TARGET/${BASENAME}Tests"
            fi
        fi
    done <<< "$CHANGED_FILES"
fi

# 3. Execute the tests
echo "🚀 Running Tests..."

# We run xcodebuild 'test' instead of 'build'
xcodebuild test -project "$PROJECT_NAME" \
           -scheme "$SCHEME_NAME" \
           -destination "id=$DEVICE_ID" \
           $TEST_FLAGS | xcpretty

# 4. Check for success/failure
if [ ${PIPESTATUS[0]} -ne 0 ]; then
    echo "❌ Tests Failed! Check the logs above."
    exit 1
else
    echo "✅ All targeted tests passed successfully!"
fi