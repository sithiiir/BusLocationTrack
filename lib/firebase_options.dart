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
    apiKey: 'AIzaSyBIHdRdcV8d7lcyjBC_DZtfRRwWZHFf0Yo',
    appId: '1:402213112341:web:70a86553f4d6fb830b1c1c',
    messagingSenderId: '402213112341',
    projectId: 'flutter-firebase-d6669',
    authDomain: 'flutter-firebase-d6669.firebaseapp.com',
    storageBucket: 'flutter-firebase-d6669.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB0ffF3gbwidEPDhvt1o7udS26w9bEHjHs',
    appId: '1:402213112341:android:47e9a728547698970b1c1c',
    messagingSenderId: '402213112341',
    projectId: 'flutter-firebase-d6669',
    storageBucket: 'flutter-firebase-d6669.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBmA3p6jp4cx1ebx0hFuxwg7U50EOoKyBI',
    appId: '1:402213112341:ios:4ba11dda50bf04f70b1c1c',
    messagingSenderId: '402213112341',
    projectId: 'flutter-firebase-d6669',
    storageBucket: 'flutter-firebase-d6669.appspot.com',
    iosBundleId: 'com.example.signinSignup',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBmA3p6jp4cx1ebx0hFuxwg7U50EOoKyBI',
    appId: '1:402213112341:ios:cb563310f81ba4760b1c1c',
    messagingSenderId: '402213112341',
    projectId: 'flutter-firebase-d6669',
    storageBucket: 'flutter-firebase-d6669.appspot.com',
    iosBundleId: 'com.example.signinSignup.RunnerTests',
  );
}
