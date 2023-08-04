import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:nectar/data/models/address.dart';
import 'package:nectar/data/models/user.dart' as user_model;
import 'package:nectar/data/services/auth_service.dart';
import 'package:nectar/data/services/firebase_firestore_service.dart';

class RegisterRepository {
  final AuthService _authService = AuthService();

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential =
        await _authService.createUserWithEmailAndPassword(
      email,
      password,
    );

    // create user data
    final user = user_model.User(
      uid: userCredential.user!.uid,
      email: email,
      displayName: userCredential.user!.displayName ?? '',
      photoUrl: userCredential.user!.photoURL ?? '',
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

  Future<void> createUserWithGoogle() async {
    UserCredential userCredential = await _authService.signInWithGoogle();

    // create user data
    final user = user_model.User(
      uid: userCredential.user!.uid,
      email: userCredential.user!.email ?? '',
      displayName: userCredential.user!.displayName ?? '',
      photoUrl: userCredential.user!.photoURL ?? '',
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

  Future<void> createUserWithFacebook() async {
    UserCredential userCredential = await _authService.signInWithFacebook();

    // create user data
    final user = user_model.User(
      uid: userCredential.user!.uid,
      email: userCredential.user!.email ?? '',
      displayName: userCredential.user!.displayName ?? '',
      photoUrl: userCredential.user!.photoURL ?? '',
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
