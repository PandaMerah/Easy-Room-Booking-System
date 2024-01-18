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
    apiKey: 'AIzaSyD_jWiUGQbhfLAhfGnlcqI-pCzRnx4GF84',
    appId: '1:23383420936:web:482bf1b4886c6d926121bd',
    messagingSenderId: '23383420936',
    projectId: 'roombookingapp-cfdf4',
    authDomain: 'roombookingapp-cfdf4.firebaseapp.com',
    storageBucket: 'roombookingapp-cfdf4.appspot.com',
    measurementId: 'G-RL9ZMPKGQV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD41c_PXqooAaAUwlIpW40YvoIMXfFl7s0',
    appId: '1:23383420936:android:10f319fab79971bb6121bd',
    messagingSenderId: '23383420936',
    projectId: 'roombookingapp-cfdf4',
    storageBucket: 'roombookingapp-cfdf4.appspot.com',
  );
}