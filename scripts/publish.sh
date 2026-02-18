#!/bin/bash

# Publish script for leblebi
# Usage: ./scripts/publish.sh <version>
# Example: ./scripts/publish.sh 1.2.0

set -e

VERSION="$1"

if [ -z "$VERSION" ]; then
    echo "Usage: $0 <version>"
    echo "Example: $0 1.2.0"
    exit 1
fi

# Validate version format (X.Y.Z)
if [[ ! "$VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "❌ Invalid version format. Expected format: X.Y.Z (e.g., 1.2.0)"
    exit 1
fi

echo "🚀 Preparing release for version $VERSION..."

# Update version in pubspec.yaml
# We append +1 build number as a default convention for Flutter
if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' "s/^version: .*/version: $VERSION+1/" pubspec.yaml
else
    sed -i "s/^version: .*/version: $VERSION+1/" pubspec.yaml
fi
echo "  ✓ pubspec.yaml updated to $VERSION+1"

# Commit changes
git add pubspec.yaml
if ! git diff --cached --quiet; then
    git commit -m "chore: bump version to $VERSION"
else
    echo "  ℹ️ pubspec.yaml already has version $VERSION+1"
fi

# Tag
if git rev-parse "v$VERSION" >/dev/null 2>&1; then
    echo "  ⚠️ Tag v$VERSION already exists. Skipping tagging."
else
    git tag -a "v$VERSION" -m "Release v$VERSION"
    echo "  ✓ Tagged v$VERSION"
fi

echo "🚀 Building macOS release locally..."
if flutter build macos --release; then
    echo "📦 Creating DMG..."
    cd build/macos/Build/Products/Release
    # Create a temporary staging directory
    rm -rf dmg_staging
    mkdir -p dmg_staging
    cp -r leblebi.app dmg_staging/
    ln -s /Applications dmg_staging/Applications

    # Create DMG using hdiutil
    hdiutil create -volname "Leblebi" -srcfolder dmg_staging -ov -format UDZO leblebi-macos.dmg

    # Clean up staging
    rm -rf dmg_staging
    cd -
    
else
    echo "  ⚠️ macOS build failed. Skipping DMG upload."
fi

echo "🚀 Building Android release locally..."
if flutter build apk --release; then
    echo "  ✓ Android APK built successfully"
    cp build/app/outputs/flutter-apk/app-release.apk build/leblebi-android.apk
else
    echo "  ⚠️ Android build failed or environment not ready. Skipping APK upload."
fi

echo "⬆️ Uploading to GitHub Release..."
FILES=()
if [ -f "build/macos/Build/Products/Release/leblebi-macos.dmg" ]; then
    FILES+=("build/macos/Build/Products/Release/leblebi-macos.dmg")
fi
if [ -f "build/leblebi-android.apk" ]; then
    FILES+=("build/leblebi-android.apk")
fi

# Check if release exists
if gh release view "v$VERSION" >/dev/null 2>&1; then
    echo "  ℹ️ Release v$VERSION already exists. Uploading assets..."
    gh release upload "v$VERSION" "${FILES[@]}" --clobber
else
    echo "  🚀 Creating new release v$VERSION..."
    gh release create "v$VERSION" "${FILES[@]}" --generate-notes
fi

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "✅ Done! Push changes with:"
echo "git push origin $CURRENT_BRANCH && git push origin v$VERSION"
