# Scheme Automation
This package contains various automation scripts that will help you automate various aspects of your flutter project.

[![Pub Package](https://img.shields.io/pub/v/flutter_automation.svg?style=flat-square)](https://pub.dartlang.org/packages/flutter_automation)


## Usage
To use this plugin, add `scheme_automation` as a [dependency in your pubspec.yaml file](https://flutter.io/docs/development/packages-and-plugins/using-packages).

## Running scripts
From terminal in your flutter project run,
```
flutter pub pub run scheme_automation --firebase-auth --google-maps --android-sign --firestore-crud
```

### 4. Scheme Base Project
Provides needed plugins and utils for base project.

```
flutter pub pub run scheme_automation --build-scheme
```

### 4. Build Dialog Utilities
Provides needed plugins and utils for base project.

```
flutter pub pub run scheme_automation --build-dialog
```

### 4.Build Theme Boilerplate
Provides needed plugins and utils for base project.

```
flutter pub pub run scheme_automation --build-theme
```

### 1. Firebase Auth
This sets up firebase authentication with google and email based login automatically in your flutter project. Also copies boilerplate login ui flow using `provider` package for state management

```
flutter pub pub run flutter_automation --build-auth
```

### 2. Google Maps
sets up google maps flutter plugin on android platform in a flutter project.

After you run the script in your flutter project you need to modify `android/app/src/main/res/values/strings.xml` file changing the text `YOUR_API_KEY` to your actual google maps Api key.

```
flutter pub pub run flutter_automation --build-maps
```

### 3. Android Signing
Generates keystore and sets up android signing config in your flutter project.

It uses `keytool` to generate keystore so, for this script to work `keytool` must be in path.

```
flutter pub pub run flutter_automation --android-sign
```

### 4. Firestore CRUD
Provides a simple firestore CRUD operation boilerplate

```
flutter pub pub run flutter_automation --build-firestore
```