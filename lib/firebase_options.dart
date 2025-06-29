// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for android - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBs3LJuMT5E-Pwqkym34RtXLPqEpQCBACE',
    appId: '1:677748726695:web:44f8163a6510de7bb07482',
    messagingSenderId: '677748726695',
    projectId: 'weather-app-4114c',
    authDomain: 'weather-app-4114c.firebaseapp.com',
    storageBucket: 'weather-app-4114c.firebasestorage.app',
    measurementId: 'G-DX2N2S7EN8',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBs3LJuMT5E-Pwqkym34RtXLPqEpQCBACE',
    appId: '1:677748726695:web:9dcaaac378e820aab07482',
    messagingSenderId: '677748726695',
    projectId: 'weather-app-4114c',
    authDomain: 'weather-app-4114c.firebaseapp.com',
    storageBucket: 'weather-app-4114c.firebasestorage.app',
    measurementId: 'G-E5T28TB87M',
  );
}
