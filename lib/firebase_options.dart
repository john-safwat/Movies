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
    apiKey: 'AIzaSyC-5ApV4kcA90HUCsdSxKCp7xGXepEZxLg',
    appId: '1:832894186541:web:ac8de28c48f13f551fb4a4',
    messagingSenderId: '832894186541',
    projectId: 'my-movies-app-e8e75',
    authDomain: 'my-movies-app-e8e75.firebaseapp.com',
    storageBucket: 'my-movies-app-e8e75.appspot.com',
    measurementId: 'G-WSS6HN66X0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBPC0onrswd6eAkGl1fEk22pRiiu2jNJl4',
    appId: '1:832894186541:android:21f92acccd93733e1fb4a4',
    messagingSenderId: '832894186541',
    projectId: 'my-movies-app-e8e75',
    storageBucket: 'my-movies-app-e8e75.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA0QsHkff2nGwv-tPTTl5zzdXPQ6N0_DVs',
    appId: '1:832894186541:ios:1558bffd06a329c21fb4a4',
    messagingSenderId: '832894186541',
    projectId: 'my-movies-app-e8e75',
    storageBucket: 'my-movies-app-e8e75.appspot.com',
    iosClientId: '832894186541-s8igqah3vn5orppsrpp5j5jgsbieeeu9.apps.googleusercontent.com',
    iosBundleId: 'com.example.movies',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA0QsHkff2nGwv-tPTTl5zzdXPQ6N0_DVs',
    appId: '1:832894186541:ios:8ea6e83d08d5fc321fb4a4',
    messagingSenderId: '832894186541',
    projectId: 'my-movies-app-e8e75',
    storageBucket: 'my-movies-app-e8e75.appspot.com',
    iosClientId: '832894186541-1kkv1k5itcel8ehj6n2s6tfksq7uqi3n.apps.googleusercontent.com',
    iosBundleId: 'com.example.movies.RunnerTests',
  );
}
