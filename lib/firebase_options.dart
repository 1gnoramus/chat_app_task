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
    apiKey: 'AIzaSyDf3GxX-AFcEakLYg8Hrk9wTajDoJstcF8',
    appId: '1:699291863845:web:876a54b3d128f24e5ea8cc',
    messagingSenderId: '699291863845',
    projectId: 'chat-app-task-7365a',
    authDomain: 'chat-app-task-7365a.firebaseapp.com',
    storageBucket: 'chat-app-task-7365a.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDfg5NUPVBMbmtrHpC74s9uQxUlsnqQLyQ',
    appId: '1:699291863845:android:821d0b82599e3acd5ea8cc',
    messagingSenderId: '699291863845',
    projectId: 'chat-app-task-7365a',
    storageBucket: 'chat-app-task-7365a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAePLPCYATg6oVELilNU_q1no4YYRH6AbA',
    appId: '1:699291863845:ios:8c242a27227e10ab5ea8cc',
    messagingSenderId: '699291863845',
    projectId: 'chat-app-task-7365a',
    storageBucket: 'chat-app-task-7365a.appspot.com',
    iosBundleId: 'com.example.chatAppTask',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAePLPCYATg6oVELilNU_q1no4YYRH6AbA',
    appId: '1:699291863845:ios:8c242a27227e10ab5ea8cc',
    messagingSenderId: '699291863845',
    projectId: 'chat-app-task-7365a',
    storageBucket: 'chat-app-task-7365a.appspot.com',
    iosBundleId: 'com.example.chatAppTask',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDf3GxX-AFcEakLYg8Hrk9wTajDoJstcF8',
    appId: '1:699291863845:web:694d3618e77bdfcb5ea8cc',
    messagingSenderId: '699291863845',
    projectId: 'chat-app-task-7365a',
    authDomain: 'chat-app-task-7365a.firebaseapp.com',
    storageBucket: 'chat-app-task-7365a.appspot.com',
  );
}
