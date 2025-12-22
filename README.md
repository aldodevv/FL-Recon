# recon

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

## live build auto_route.
- dart run build_runner watch
## live one time auto_route.
- dart run build_runner build

## generate service locator
flutter pub run build_runner build --delete-conflicting-outputs

## run dev
flutter run --flavor dev
## run uat
flutter run --flavor uat

## Android Build : 
## build APK obfuscate (dev / uat / staging / prod)
flutter build apk \
  --flavor prod \
  -t lib/main.dart \
  --release \
  --obfuscate \
  --split-debug-info=obfuscation/android/prod

## build AAB obfuscate (Play Store)
flutter build appbundle \
  --flavor prod \
  -t lib/main.dart \
  --release \
  --obfuscate \
  --split-debug-info=obfuscation/android/prod

## generate JSON map original symbol → obfuscated symbol
flutter build appbundle \
  --flavor prod \
  -t lib/main.dart \
  --release \
  --obfuscate \
  --split-debug-info=obfuscation/android/prod \
  --extra-gen-snapshot-options=--save-obfuscation-map=obfuscation/android/prod/map.json

## de-obfuscate stacktrace Android 
flutter symbolize \
  -i crash.txt \
  -d obfuscation/android/prod/app.android-arm64.symbols

## Ios Build : 
## build IPA obfuscate (dev / uat / staging / prod)
flutter build ipa \
  --flavor prod \
  -t lib/main.dart \
  --release \
  --obfuscate \
  --split-debug-info=obfuscation/ios/prod

## de-obfuscate stacktrace iOS
flutter symbolize \
  -i crash.txt \
  -d obfuscation/ios/prod/app.ios-arm64.symbols

## Android Build
## build APK obfuscate (dev / uat / prod)
flutter build apk --flavor dev -t lib/main_dev.dart --release --obfuscate --split-debug-info=obfuscation/android/dev