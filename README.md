# Lumina Quiz (FocusBuddy App)

Lumina Quiz is a gamified study and quiz application built with Flutter. It helps users stay engaged and learn effectively through quiz categories, customizable themes, companion character leveling, and a built-in virtual shop.

## 🚀 Features

* **Gamified Quiz Engine**: Multiple quiz categories to test your knowledge.
* **Character Companions**: Unlock, equip, and level up unique virtual characters (Focus Buddies).
* **Virtual Shop**: Earn coins by playing quizzes and spend them in the shop to purchase new companion characters and themes.
* **Dynamic Themes**: Equip different visually rich themes with dynamic, animated backgrounds and customizable ambient overlays.
* **Progress Tracking**: Tracks your quiz results, score history, and user level.
* **State Management**: Clean architecture powered by `provider` for global state and theme management.
* **Local Database**: Persistent local storage powered by `sqflite` and `shared_preferences`.

## 🛠️ Tech Stack & Dependencies

* **Framework**: Flutter (Dart)
* **State Management**: `provider`
* **Local Databases**: `sqflite`, `shared_preferences`
* **Network & Connectivity**: `http`, `connectivity_plus`
* **Assets**: Rich images, animations, and custom theme layouts

## 📦 Building the App

### Prerequisites
* Flutter SDK (version `^3.9.2` or later)
* Android SDK (for Android builds)

### Steps

1. **Clone the repository**:
   ```bash
   git clone https://github.com/krishflutter993/softskills_assignment.git
   cd softskills_assignment
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the app**:
   ```bash
   flutter run
   ```

4. **Build Release APKs**:
   ```bash
   flutter build apk --split-per-abi
   ```
   This will generate:
   - Release APK (ARM64): ``
   - Release APK (ARMv7): `build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk`
   - Release APK (x86_64): `build/app/outputs/flutter-apk/app-x86_64-release.apk`

## 🤖 CI/CD with GitHub Actions

This repository is configured with a GitHub Actions workflow (`.github/workflows/build_apk.yml`) that automatically:
1. Builds the Flutter application on every push to the `main` branch.
2. Generates architecture-specific release APKs (ARM64, ARMv7, x86_64).
3. Publishes a GitHub Release and uploads the APKs as release assets automatically when a tag matching `v*` is pushed or the workflow is dispatched manually.
