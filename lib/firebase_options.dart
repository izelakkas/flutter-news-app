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
    apiKey: 'AIzaSyDOeoQxM-jc4BLgZU1Kib-_l3FKeHGDPc0',
    appId: '1:889157287402:web:6cbfc64721dee731c94693',
    messagingSenderId: '889157287402',
    projectId: 'izelakkas-94669',
    authDomain: 'izelakkas-94669.firebaseapp.com',
    storageBucket: 'izelakkas-94669.appspot.com',
    measurementId: 'G-6EDHF01R3T',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBMly5oOAphq2Jkm5Y6dDVBlM3Axp1y3Hc',
    appId: '1:889157287402:android:2db02c010755d1f9c94693',
    messagingSenderId: '889157287402',
    projectId: 'izelakkas-94669',
    storageBucket: 'izelakkas-94669.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBmWBG5rplimSODOx5fmD4NVOJedqzaxCg',
    appId: '1:889157287402:ios:3c8ab339cfd8e5d8c94693',
    messagingSenderId: '889157287402',
    projectId: 'izelakkas-94669',
    storageBucket: 'izelakkas-94669.appspot.com',
    iosClientId: '889157287402-qf4d6o1if7d0mci7vupibafckc4aseuv.apps.googleusercontent.com',
    iosBundleId: 'com.izelakkas',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBmWBG5rplimSODOx5fmD4NVOJedqzaxCg',
    appId: '1:889157287402:ios:3c8ab339cfd8e5d8c94693',
    messagingSenderId: '889157287402',
    projectId: 'izelakkas-94669',
    storageBucket: 'izelakkas-94669.appspot.com',
    iosClientId: '889157287402-qf4d6o1if7d0mci7vupibafckc4aseuv.apps.googleusercontent.com',
    iosBundleId: 'com.izelakkas',
  );
}
