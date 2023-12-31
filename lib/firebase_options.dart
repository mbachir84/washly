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
    apiKey: 'AIzaSyDacDA-6MjBavGCfowwQkjgsVU_Osvmzhw',
    appId: '1:810638852135:web:15b1fc6df7e2b58bb48e02',
    messagingSenderId: '810638852135',
    projectId: 'washly-b8ab4',
    authDomain: 'washly-b8ab4.firebaseapp.com',
    storageBucket: 'washly-b8ab4.appspot.com',
    measurementId: 'G-XE9TD8P878',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyByew2vsadLXa8GLYx2sBwgtArokXbLbpI',
    appId: '1:810638852135:android:458680e3eb6091dab48e02',
    messagingSenderId: '810638852135',
    projectId: 'washly-b8ab4',
    storageBucket: 'washly-b8ab4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCVCmfv1ALdoMFTHAhhfmxO72JEm_RkGas',
    appId: '1:810638852135:ios:d2e065637ac4605db48e02',
    messagingSenderId: '810638852135',
    projectId: 'washly-b8ab4',
    storageBucket: 'washly-b8ab4.appspot.com',
    androidClientId: '810638852135-di4ilqsbmqcd6m8dlt73uq0cgftl2c5q.apps.googleusercontent.com',
    iosClientId: '810638852135-svfi8rrktdv2tnjj5grs877j2dtb4ej1.apps.googleusercontent.com',
    iosBundleId: 'com.example.washly',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCVCmfv1ALdoMFTHAhhfmxO72JEm_RkGas',
    appId: '1:810638852135:ios:76bf6770fac14470b48e02',
    messagingSenderId: '810638852135',
    projectId: 'washly-b8ab4',
    storageBucket: 'washly-b8ab4.appspot.com',
    androidClientId: '810638852135-di4ilqsbmqcd6m8dlt73uq0cgftl2c5q.apps.googleusercontent.com',
    iosClientId: '810638852135-50qkoqaiiu23m18su6mevnurhegtns4r.apps.googleusercontent.com',
    iosBundleId: 'com.example.washly.RunnerTests',
  );
}
