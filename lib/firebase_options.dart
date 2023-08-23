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
    apiKey: 'AIzaSyBkk8MUuK5Ck7tUJUqzFdzx7o04_m5358U',
    appId: '1:300507568093:web:25d0897588451583178834',
    messagingSenderId: '300507568093',
    projectId: 'flutter-reddit-fb542',
    authDomain: 'flutter-reddit-fb542.firebaseapp.com',
    storageBucket: 'flutter-reddit-fb542.appspot.com',
    measurementId: 'G-ET9BHTQ6X1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBeuW_O5flVTE6kSH3iqkTeUkBmzKgk4J8',
    appId: '1:300507568093:android:a6f57c75cd2cf966178834',
    messagingSenderId: '300507568093',
    projectId: 'flutter-reddit-fb542',
    storageBucket: 'flutter-reddit-fb542.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAwa-RbGTjE1qfPufwhg1v4unisxSZPTUw',
    appId: '1:300507568093:ios:a5ecec743f27f133178834',
    messagingSenderId: '300507568093',
    projectId: 'flutter-reddit-fb542',
    storageBucket: 'flutter-reddit-fb542.appspot.com',
    androidClientId: '300507568093-jld55epfcejlrlgd5fhm155igflupf3k.apps.googleusercontent.com',
    iosClientId: '300507568093-m29jat1484c1slbf4b3mcar73bbo9aor.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterReddit',
  );
}