// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBHA_i4_AcrrtJdoBot1WXAIJlr0LE__Ms',
    appId: '1:296176706009:web:f22e2ad650ca79ae26b9c8',
    messagingSenderId: '296176706009',
    projectId: 'flutter-merchant-ada35',
    authDomain: 'flutter-merchant-ada35.firebaseapp.com',
    storageBucket: 'flutter-merchant-ada35.appspot.com',
    measurementId: 'G-J9XMP415QM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAJbCzziM-DeoHXCCLcrtBYwJ0QYwvttuc',
    appId: '1:296176706009:android:d4ee318fc732de8326b9c8',
    messagingSenderId: '296176706009',
    projectId: 'flutter-merchant-ada35',
    storageBucket: 'flutter-merchant-ada35.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCCDjNUrLWpdo2pIvJmg4z9ptBhlbROLBc',
    appId: '1:296176706009:ios:5af3296059d1cab526b9c8',
    messagingSenderId: '296176706009',
    projectId: 'flutter-merchant-ada35',
    storageBucket: 'flutter-merchant-ada35.appspot.com',
    iosClientId: '296176706009-jgu24slgvevhaahmpugao3rh2ou5qrdl.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterMerchant',
  );
}