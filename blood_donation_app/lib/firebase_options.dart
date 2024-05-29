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
    apiKey: 'AIzaSyDmUPLI-9ixh6yQnsgZxsHcTLdIgCBZ3H4',
    appId: '1:1008863819279:web:96198ec33e2f463cf8d57a',
    messagingSenderId: '1008863819279',
    projectId: 'blood-donation-app-5daa5',
    authDomain: 'blood-donation-app-5daa5.firebaseapp.com',
    storageBucket: 'blood-donation-app-5daa5.appspot.com',
    measurementId: 'G-BPTXGFMH36',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCr7tljGcrsS6tgOCcufA6o-p57xZgF8kU',
    appId: '1:1008863819279:ios:2381ca88112ac084f8d57a',
    messagingSenderId: '1008863819279',
    projectId: 'blood-donation-app-5daa5',
    storageBucket: 'blood-donation-app-5daa5.appspot.com',
    iosBundleId: 'com.example.bloodDonationApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCr7tljGcrsS6tgOCcufA6o-p57xZgF8kU',
    appId: '1:1008863819279:ios:2381ca88112ac084f8d57a',
    messagingSenderId: '1008863819279',
    projectId: 'blood-donation-app-5daa5',
    storageBucket: 'blood-donation-app-5daa5.appspot.com',
    iosBundleId: 'com.example.bloodDonationApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDmUPLI-9ixh6yQnsgZxsHcTLdIgCBZ3H4',
    appId: '1:1008863819279:web:faebd318195b4d39f8d57a',
    messagingSenderId: '1008863819279',
    projectId: 'blood-donation-app-5daa5',
    authDomain: 'blood-donation-app-5daa5.firebaseapp.com',
    storageBucket: 'blood-donation-app-5daa5.appspot.com',
    measurementId: 'G-SHYZ4BH6LE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBslUpdg8-o6y2FJLEtxDdQMeWHWHiH7ZI',
    appId: '1:1008863819279:android:f49cf1bfdba84d00f8d57a',
    messagingSenderId: '1008863819279',
    projectId: 'blood-donation-app-5daa5',
    storageBucket: 'blood-donation-app-5daa5.appspot.com',
  );

}