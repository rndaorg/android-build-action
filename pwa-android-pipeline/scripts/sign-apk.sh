#!/bin/bash
set -e

echo "Setting up APK signing..."

# Create keystore from base64
echo "$KEYSTORE_BASE64" | base64 -d > keystore.jks

# Find the Android package directory
if [ -d "android-package" ]; then
    cd android-package
elif [ -d "android" ]; then
    cd android
else
    echo "No Android package directory found"
    exit 1
fi

# Sign the APK
if [ -f "gradlew" ]; then
    ./gradlew assembleRelease \
        -Pandroid.injected.signing.store.file=../keystore.jks \
        -Pandroid.injected.signing.store.password="$KEYSTORE_PASSWORD" \
        -Pandroid.injected.signing.key.alias="$KEY_ALIAS" \
        -Pandroid.injected.signing.key.password="$KEY_PASSWORD"
else
    echo "gradlew not found"
    exit 1
fi

echo "APK signing completed"