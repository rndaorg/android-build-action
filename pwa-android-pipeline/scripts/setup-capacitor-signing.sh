#!/bin/bash
set -e

echo "Setting up Capacitor signing..."

# Create Android app directory if it doesn't exist
mkdir -p android/app/

# Create keystore from base64
echo "$KEYSTORE_BASE64" | base64 -d > android/app/keystore.jks

# Create key.properties file
cat > android/key.properties << EOF
storePassword=$KEYSTORE_PASSWORD
keyPassword=$KEY_PASSWORD
keyAlias=$KEY_ALIAS
storeFile=keystore.jks
EOF

echo "Capacitor signing setup completed"