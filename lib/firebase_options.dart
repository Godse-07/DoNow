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
    apiKey: 'AIzaSyA-lT9BcySeSqwvUqAGV0dDUI0yz2DL-Rg',
    appId: '1:299315088450:web:bdb5c2e0727260437af1db',
    messagingSenderId: '299315088450',
    projectId: 'todoapp-132aa',
    authDomain: 'todoapp-132aa.firebaseapp.com',
    storageBucket: 'todoapp-132aa.appspot.com',
    measurementId: 'G-NPSH5NDM2Q',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCEi-dLTHLirJrJYRZ3DyW5nsldw87tZ0Y',
    appId: '1:299315088450:android:804faf6edef3843d7af1db',
    messagingSenderId: '299315088450',
    projectId: 'todoapp-132aa',
    storageBucket: 'todoapp-132aa.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAuwv2ESqbv9mkK3_nvhfxESApux6fYIic',
    appId: '1:299315088450:ios:3329b937863650e57af1db',
    messagingSenderId: '299315088450',
    projectId: 'todoapp-132aa',
    storageBucket: 'todoapp-132aa.appspot.com',
    iosBundleId: 'com.example.toDoApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAuwv2ESqbv9mkK3_nvhfxESApux6fYIic',
    appId: '1:299315088450:ios:3329b937863650e57af1db',
    messagingSenderId: '299315088450',
    projectId: 'todoapp-132aa',
    storageBucket: 'todoapp-132aa.appspot.com',
    iosBundleId: 'com.example.toDoApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA-lT9BcySeSqwvUqAGV0dDUI0yz2DL-Rg',
    appId: '1:299315088450:web:19114064b87385907af1db',
    messagingSenderId: '299315088450',
    projectId: 'todoapp-132aa',
    authDomain: 'todoapp-132aa.firebaseapp.com',
    storageBucket: 'todoapp-132aa.appspot.com',
    measurementId: 'G-G9FXCVV9ZG',
  );
}
