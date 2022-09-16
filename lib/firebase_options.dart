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
    apiKey: 'AIzaSyCukX-_SM7nCRtvTBXJzCOdgR3ZE0NOWq4',
    appId: '1:680626630554:web:88e6788b7215aec243d423',
    messagingSenderId: '680626630554',
    projectId: 'client-hub-3fb68',
    authDomain: 'client-hub-3fb68.firebaseapp.com',
    databaseURL: 'https://client-hub-3fb68-default-rtdb.firebaseio.com',
    storageBucket: 'client-hub-3fb68.appspot.com',
    measurementId: 'G-78QK1DFQBR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCG2VtiXl4YbY62z2klRvcMKw29hTscnRk',
    appId: '1:680626630554:android:b11c7018cf9401e643d423',
    messagingSenderId: '680626630554',
    projectId: 'client-hub-3fb68',
    databaseURL: 'https://client-hub-3fb68-default-rtdb.firebaseio.com',
    storageBucket: 'client-hub-3fb68.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAK9Kvvwra2a3rdW-DLRNAHZ5fbUBkTOBQ',
    appId: '1:680626630554:ios:a3b277cb864e02d143d423',
    messagingSenderId: '680626630554',
    projectId: 'client-hub-3fb68',
    databaseURL: 'https://client-hub-3fb68-default-rtdb.firebaseio.com',
    storageBucket: 'client-hub-3fb68.appspot.com',
    iosClientId: '680626630554-tp89nrn5pm6q55i4eiehtk6qddsfkbhc.apps.googleusercontent.com',
    iosBundleId: 'com.example.clientHub',
  );
}