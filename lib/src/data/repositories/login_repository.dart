import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:nectar/src/data/models/address.dart';
import 'package:nectar/src/data/models/user.dart' as user_model;
import 'package:nectar/src/data/services/auth_service.dart';
import 'package:nectar/src/data/services/firebase_firestore_service.dart';

class LoginRepository {
  final AuthService _authService = AuthService();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential =
        await _authService.signInWithEmailAndPassword(
      email,
      password,
    );

    // get user data from firestore
    final snapshot = await FirebaseFirestoreService().getDocumentsWithQuery(
      'users',
      'uid',
      userCredential.user!.uid,
    );

    // convert to model
    final user = user_model.User.fromMap(
        snapshot.docs.first.data() as Map<String, dynamic>);

    // save to hive
    await Hive.box('myBox').put('user', user);
  }

  Future<void> signInWithGoogle() async {
    UserCredential userCredential = await _authService.signInWithGoogle();

    try {
      // get user data from firestore
      final snapshot = await FirebaseFirestoreService().getDocumentsWithQuery(
        'users',
        'uid',
        userCredential.user!.uid,
      );
      // convert to model
      final user = user_model.User.fromMap(
          snapshot.docs.first.data() as Map<String, dynamic>);

      // save to hive
      await Hive.box('myBox').put('user', user);
    } catch (e) {
      // user not found, create new user

      user_model.User user = user_model.User(
        uid: userCredential.user!.uid,
        email: userCredential.user!.email ?? '',
        displayName: userCredential.user!.displayName ?? '',
        photoUrl: userCredential.user!.photoURL,
        phoneNumber: userCredential.user!.phoneNumber ?? '',
        address: Address.empty(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // save to firestore
      await FirebaseFirestoreService().addDocument(
        'users',
        user.toMap(),
      );
      // save to hive
      await Hive.box('myBox').put('user', user);
    }
  }

  Future<void> signInWithFacebook() async {
    UserCredential userCredential = await _authService.signInWithFacebook();

    try {
      // get user data from firestore
      final snapshot = await FirebaseFirestoreService().getDocumentsWithQuery(
        'users',
        'uid',
        userCredential.user!.uid,
      );
      // convert to model
      final user = user_model.User.fromMap(
          snapshot.docs.first.data() as Map<String, dynamic>);

      // save to hive
      await Hive.box('myBox').put('user', user);
    } catch (e) {
      // user not found, create new user

      user_model.User user = user_model.User(
        uid: userCredential.user!.uid,
        email: userCredential.user!.email ?? '',
        displayName: userCredential.user!.displayName ?? '',
        photoUrl: userCredential.user!.photoURL,
        phoneNumber: userCredential.user!.phoneNumber ?? '',
        address: Address.empty(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // save to firestore
      await FirebaseFirestoreService().addDocument(
        'users',
        user.toMap(),
      );
      // save to hive
      await Hive.box('myBox').put('user', user);
    }
  }
}
