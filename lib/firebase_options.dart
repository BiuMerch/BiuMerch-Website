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
    apiKey: 'AIzaSyCzuFlmG11jY5sm3fezesLd_MmFYndhctg',
    appId: '1:930011368188:web:0051e66d92c946768aa579',
    messagingSenderId: '930011368188',
    projectId: 'simirpl22a-biumerch-51620',
    authDomain: 'simirpl22a-biumerch-51620.firebaseapp.com',
    storageBucket: 'simirpl22a-biumerch-51620.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCYXvx5wSyyPsfPM3zC42nEEqmTnEHFWdw',
    appId: '1:930011368188:android:4a82a2a8912361bb8aa579',
    messagingSenderId: '930011368188',
    projectId: 'simirpl22a-biumerch-51620',
    storageBucket: 'simirpl22a-biumerch-51620.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA5v2wa2gmgL76vtEccq9qyG7L0BlpyRS4',
    appId: '1:930011368188:ios:8d06786a470cf8208aa579',
    messagingSenderId: '930011368188',
    projectId: 'simirpl22a-biumerch-51620',
    storageBucket: 'simirpl22a-biumerch-51620.appspot.com',
    iosBundleId: 'com.example.apa',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA5v2wa2gmgL76vtEccq9qyG7L0BlpyRS4',
    appId: '1:930011368188:ios:8d06786a470cf8208aa579',
    messagingSenderId: '930011368188',
    projectId: 'simirpl22a-biumerch-51620',
    storageBucket: 'simirpl22a-biumerch-51620.appspot.com',
    iosBundleId: 'com.example.apa',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCzuFlmG11jY5sm3fezesLd_MmFYndhctg',
    appId: '1:930011368188:web:36458c5843d82bda8aa579',
    messagingSenderId: '930011368188',
    projectId: 'simirpl22a-biumerch-51620',
    authDomain: 'simirpl22a-biumerch-51620.firebaseapp.com',
    storageBucket: 'simirpl22a-biumerch-51620.appspot.com',
  );
}
