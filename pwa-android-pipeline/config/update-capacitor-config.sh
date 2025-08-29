#!/bin/bash
set -e

PACKAGE_NAME="$1"
APP_NAME="$2"
APP_VERSION="$3"
CONFIG_PATH="$4"

echo "Updating Capacitor config..."

# Create or update capacitor.config.ts
cat > "$CONFIG_PATH" << EOF
import { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: '$PACKAGE_NAME',
  appName: '$APP_NAME',
  webDir: 'build',
  server: {
    androidScheme: 'https'
  },
  android: {
    buildOptions: {
      keystorePath: 'keystore.jks',
      keystorePassword: process.env.KEYSTORE_PASSWORD,
      keystoreAlias: process.env.KEY_ALIAS,
      keystoreAliasPassword: process.env.KEY_PASSWORD,
      releaseType: 'APK'
    }
  },
  plugins: {
    SplashScreen: {
      launchShowDuration: 3000,
      backgroundColor: "#ffffff",
      showSpinner: false
    }
  }
};

export default config;
EOF

echo "Capacitor config updated"