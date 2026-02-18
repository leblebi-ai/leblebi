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

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "✅ Done! Push changes with:"
echo "git push origin $CURRENT_BRANCH && git push origin v$VERSION"
