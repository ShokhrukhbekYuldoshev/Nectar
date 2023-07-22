import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadFile(String path, File file) async {
    final ref = _firebaseStorage.ref().child(path);
    final uploadTask = ref.putFile(file);
    final snapshot = await uploadTask.whenComplete(() => null);
    return await snapshot.ref.getDownloadURL();
  }

  Future<void> deleteFile(String path) async {
    final ref = _firebaseStorage.ref().child(path);
    await ref.delete();
  }

  Future<String> getFileUrl(String path) async {
    final ref = _firebaseStorage.ref().child(path);
    return await ref.getDownloadURL();
  }
}
