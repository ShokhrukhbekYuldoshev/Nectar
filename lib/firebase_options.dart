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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB-Ylj38gTsHRHY-8aM6--aWCKSJjY8_Es',
    appId: '1:403064089399:android:b8b1a1660741ab6a2008b2',
    messagingSenderId: '403064089399',
    projectId: 'nectar-8e579',
    storageBucket: 'nectar-8e579.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDE-hzoVCTN6nVhVWwrjMsFaaR1VVyLzU8',
    appId: '1:403064089399:ios:6242d5c8d50d83692008b2',
    messagingSenderId: '403064089399',
    projectId: 'nectar-8e579',
    storageBucket: 'nectar-8e579.appspot.com',
    androidClientId: '403064089399-arrn7dmiuflnsmi2piboirrvjrmviisb.apps.googleusercontent.com',
    iosClientId: '403064089399-ofsc4ts7siul9vk0j5evlm5vcfh31u7i.apps.googleusercontent.com',
    iosBundleId: 'com.shokhrukhbek.nectar',
  );
}
