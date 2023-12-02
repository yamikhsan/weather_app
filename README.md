## How to Install

- [Install Firebase CLI.](https://firebase.google.com/docs/cli#setup_update_cli)
- Log into Firebase using your Google account by running the following command:
```
$ firebase login
```
- Install the FlutterFire CLI by running the following command from any directory:
```
$ dart pub global activate flutterfire_cli
```
- Run the following command to start the app configuration workflow:
```
$ flutterfire configure
```
- Enable Email/Password, Phone and Google as a Sign-In method in the [Firebase console](https://console.firebase.google.com).
- Required [certificate SHA-1](https://developers.google.com/android/guides/client-auth) for debug signing Phone Number and Google Sign-In.
- Create an .env file in the root project and add the openweathermap.org API key to the file:
```
API_KEY='{openweathermap_api_key}'
```
- flutter pub get
- cd ios & pod install (if it wants to run on iOS)
- open an emulator or simulator or connect to a real device
- flutter run

[Download APK](https://github.com/yamikhsan/weather_app/releases)
