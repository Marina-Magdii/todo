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
    apiKey: 'AIzaSyBOfTwnpLCuIeLj_PjFmd4R47fEIFWHSkg',
    appId: '1:40126899505:web:c71199e217fb9f147f7c10',
    messagingSenderId: '40126899505',
    projectId: 'todo-52b31',
    authDomain: 'todo-52b31.firebaseapp.com',
    storageBucket: 'todo-52b31.appspot.com',
    measurementId: 'G-RCDTMB04RM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAP8az75Z-BqupS_wG2g11X24lAwuev830',
    appId: '1:40126899505:android:ef49f1205055b26a7f7c10',
    messagingSenderId: '40126899505',
    projectId: 'todo-52b31',
    storageBucket: 'todo-52b31.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBb36cXAt2soiE9SBMmf6e7PtHjR4dnjdk',
    appId: '1:40126899505:ios:2e02943dd96365b17f7c10',
    messagingSenderId: '40126899505',
    projectId: 'todo-52b31',
    storageBucket: 'todo-52b31.appspot.com',
    iosBundleId: 'com.example.todoApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBb36cXAt2soiE9SBMmf6e7PtHjR4dnjdk',
    appId: '1:40126899505:ios:2e02943dd96365b17f7c10',
    messagingSenderId: '40126899505',
    projectId: 'todo-52b31',
    storageBucket: 'todo-52b31.appspot.com',
    iosBundleId: 'com.example.todoApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBOfTwnpLCuIeLj_PjFmd4R47fEIFWHSkg',
    appId: '1:40126899505:web:86a3d8777aa216797f7c10',
    messagingSenderId: '40126899505',
    projectId: 'todo-52b31',
    authDomain: 'todo-52b31.firebaseapp.com',
    storageBucket: 'todo-52b31.appspot.com',
    measurementId: 'G-FRQGLEWPJM',
  );

}