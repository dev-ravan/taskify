// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBTUT2SAvsMH4V6IMR3dWZs9vlTMwTVnP0',
    appId: '1:485418523975:web:722edee5067ce79bde0062',
    messagingSenderId: '485418523975',
    projectId: 'taskify-601bd',
    authDomain: 'taskify-601bd.firebaseapp.com',
    storageBucket: 'taskify-601bd.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCIi9w09CC6s7q3EufQOr-t8qCKoBfm3Iw',
    appId: '1:485418523975:android:c4c1fb72361eaca6de0062',
    messagingSenderId: '485418523975',
    projectId: 'taskify-601bd',
    storageBucket: 'taskify-601bd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDWsJO5qCswmuOG3RRsXQIBZcHRbMkWZpM',
    appId: '1:485418523975:ios:dc57a6166f77aafbde0062',
    messagingSenderId: '485418523975',
    projectId: 'taskify-601bd',
    storageBucket: 'taskify-601bd.appspot.com',
    iosBundleId: 'com.example.taskify',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDWsJO5qCswmuOG3RRsXQIBZcHRbMkWZpM',
    appId: '1:485418523975:ios:cabee9d9cc66adaede0062',
    messagingSenderId: '485418523975',
    projectId: 'taskify-601bd',
    storageBucket: 'taskify-601bd.appspot.com',
    iosBundleId: 'com.example.taskify.RunnerTests',
  );
}
