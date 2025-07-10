#!/bin/bash

echo "🚀 Creating Brij Sakhi APK..."

# Create a simple APK structure
mkdir -p brij-sakhi-apk/META-INF/com/google/android
mkdir -p brij-sakhi-apk/assets
mkdir -p brij-sakhi-apk/res/drawable

# Copy app files
cp -r assets/* brij-sakhi-apk/assets/
cp index.html brij-sakhi-apk/assets/
cp manifest.json brij-sakhi-apk/assets/

# Create a simple APK manifest
cat > brij-sakhi-apk/AndroidManifest.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.brijsakhi.app"
    android:versionCode="1"
    android:versionName="1.0">

    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

    <application
        android:allowBackup="true"
        android:icon="@drawable/ic_launcher"
        android:label="Brij Sakhi"
        android:theme="@android:style/Theme.NoTitleBar">
        
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:theme="@android:style/Theme.NoTitleBar.Fullscreen">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>
</manifest>
EOF

# Create a simple Java activity
cat > brij-sakhi-apk/MainActivity.java << 'EOF'
package com.brijsakhi.app;

import android.app.Activity;
import android.os.Bundle;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.webkit.WebSettings;

public class MainActivity extends Activity {
    private WebView webView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        webView = new WebView(this);
        setContentView(webView);
        
        WebSettings webSettings = webView.getSettings();
        webSettings.setJavaScriptEnabled(true);
        webSettings.setDomStorageEnabled(true);
        webSettings.setAllowFileAccess(true);
        webSettings.setAllowContentAccess(true);
        
        webView.setWebViewClient(new WebViewClient());
        webView.loadUrl("file:///android_asset/index.html");
    }
    
    @Override
    public void onBackPressed() {
        if (webView.canGoBack()) {
            webView.goBack();
        } else {
            super.onBackPressed();
        }
    }
}
EOF

echo "✅ APK structure created!"
echo "📱 APK files ready in: brij-sakhi-apk/"
echo ""
echo "🌐 For online APK generation, visit:"
echo "   https://www.pwabuilder.com/"
echo "   Enter URL: http://$(hostname -I | awk '{print $1}'):8080"
echo ""
echo "📋 Alternative: Use Android Studio to build APK from the generated files"