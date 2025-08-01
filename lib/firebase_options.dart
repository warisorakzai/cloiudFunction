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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBLUSsWcZQV_6sP13banKTIO2jiIyhph9w',
    appId: '1:1001936629520:web:786dccc8822420baaa3f95',
    messagingSenderId: '1001936629520',
    projectId: 'gppp-d12b9',
    authDomain: 'gppp-d12b9.firebaseapp.com',
    storageBucket: 'gppp-d12b9.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC6xK32lJKbWIC3fOWXqUxEWB1rK9aQwlA',
    appId: '1:1001936629520:android:d3eb6e4dc6ed57aeaa3f95',
    messagingSenderId: '1001936629520',
    projectId: 'gppp-d12b9',
    storageBucket: 'gppp-d12b9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC2hVpp8EKa5gJRec9orhl75cQqnu2DWbI',
    appId: '1:1001936629520:ios:3822570df61ffbdbaa3f95',
    messagingSenderId: '1001936629520',
    projectId: 'gppp-d12b9',
    storageBucket: 'gppp-d12b9.appspot.com',
    iosBundleId: 'com.example.cloudfunction',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBLUSsWcZQV_6sP13banKTIO2jiIyhph9w',
    appId: '1:1001936629520:web:786dccc8822420baaa3f95',
    messagingSenderId: '1001936629520',
    projectId: 'gppp-d12b9',
    authDomain: 'gppp-d12b9.firebaseapp.com',
    storageBucket: 'gppp-d12b9.appspot.com',
  );
}