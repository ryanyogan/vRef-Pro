# vRef Pro
### How to upgrade Flutter & Fix Cocoa Pod issues

If you are coming from x86 (Intel) to arm64 (Apple Silicon M Chip)
then you will need to perform the following:

```
cd ios
pod clean-cache --all
arch -x86_64 pod install --repo-update
pod install

```

### Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### Additional Documentation

Do this steps once put 4 files in their right path

1. go to tools Menu/ Flutter / Flutter Upgrade 

2. go to tools Menu/ Flutter /  Flutter pug get

3. go to tools Menu/ Flutter /  Flutter pug Upgrade