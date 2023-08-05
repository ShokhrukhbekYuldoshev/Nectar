import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nectar/data/models/product.dart';
import 'package:nectar/data/models/review.dart';
import 'package:nectar/data/models/store.dart';
import 'package:nectar/data/services/firebase_firestore_service.dart';
import 'package:nectar/data/models/user.dart' as user_model;

class StoreDetailsRepository {
  final FirebaseFirestoreService _firebaseFirestoreService =
      FirebaseFirestoreService();

  static var box = Hive.box('myBox');

  Future<List<Product>> getProducts(String storeId) async {
    DocumentReference storeRef =
        FirebaseFirestore.instance.collection('stores').doc(storeId);
    var snapshot = await _firebaseFirestoreService.getDocumentsWithQuery(
      'products',
      "store",
      storeRef,
    );

    return snapshot.docs
        .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>)
            .copyWith(id: doc.id)) // set the product ID to the document ID
        .toList();
  }

  Future<List<Review>> getReviews(String storeId) async {
    DocumentReference storeRef =
        FirebaseFirestore.instance.collection('stores').doc(storeId);
    var snapshot = await _firebaseFirestoreService.getDocumentsWithQuery(
      'reviews',
      'target',
      storeRef,
    );

    return snapshot.docs
        .map((doc) => Review.fromMap(doc.data() as Map<String, dynamic>)
            .copyWith(id: doc.id)) // set the review ID to the document ID
        .toList();
  }

  static bool isFavorite(Store store) {
    // get user
    user_model.User user = box.get("user");

    // initialize favoriteStores if null
    user.favoriteStores ??= [];

    // check if store is in favorite
    return user.favoriteStores?.contains(
          FirebaseFirestore.instance.collection('stores').doc(store.id),
        ) ??
        false;
  }

  Future<void> updateFavorite(Store store, bool isFavorite) async {
    // get user
    user_model.User user = box.get("user");

    // initialize favoriteStores if null
    user.favoriteStores ??= [];

    // add or remove store from favorite
    if (isFavorite) {
      user.favoriteStores?.add(
        FirebaseFirestore.instance.collection('stores').doc(store.id),
      );
    } else {
      user.favoriteStores?.remove(
        FirebaseFirestore.instance.collection('stores').doc(store.id),
      );
    }

    // update user
    await box.put("user", user);

    // update in firestore
    await _firebaseFirestoreService.updateDocumentWithQuery(
      collection: "users",
      field: "uid",
      value: user.uid,
      data: {
        "favoriteStores": user.favoriteStores,
      },
    );
  }
}
