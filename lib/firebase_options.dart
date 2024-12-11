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
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
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
    apiKey: 'AIzaSyDieL5tF3iZXN7OOLakkpdoG34snQjdR0w',
    appId: '1:504303969477:web:65465cd88c79c0365cfcac',
    messagingSenderId: '504303969477',
    projectId: 'smartgarden-28150',
    authDomain: 'smartgarden-28150.firebaseapp.com',
    storageBucket: 'smartgarden-28150.firebasestorage.app',
    measurementId: 'G-M4RWL96DV3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDo3dPZbCZ57jb49M3O-Qs9C-hRHAR9X4Y',
    appId: '1:504303969477:android:4a2852a6738b60495cfcac',
    messagingSenderId: '504303969477',
    projectId: 'smartgarden-28150',
    storageBucket: 'smartgarden-28150.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBHw4obx0CT9WknbH7m_lwmtf8Ouesq6w8',
    appId: '1:504303969477:ios:5ecd33c1b7dd1e525cfcac',
    messagingSenderId: '504303969477',
    projectId: 'smartgarden-28150',
    storageBucket: 'smartgarden-28150.firebasestorage.app',
    iosBundleId: 'com.example.smartgardenApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBHw4obx0CT9WknbH7m_lwmtf8Ouesq6w8',
    appId: '1:504303969477:ios:5ecd33c1b7dd1e525cfcac',
    messagingSenderId: '504303969477',
    projectId: 'smartgarden-28150',
    storageBucket: 'smartgarden-28150.firebasestorage.app',
    iosBundleId: 'com.example.smartgardenApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDieL5tF3iZXN7OOLakkpdoG34snQjdR0w',
    appId: '1:504303969477:web:b81dfcc05af814635cfcac',
    messagingSenderId: '504303969477',
    projectId: 'smartgarden-28150',
    authDomain: 'smartgarden-28150.firebaseapp.com',
    storageBucket: 'smartgarden-28150.firebasestorage.app',
    measurementId: 'G-S722K5MVHF',
  );
}