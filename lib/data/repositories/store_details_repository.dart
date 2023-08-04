import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nectar/data/models/product.dart';
import 'package:nectar/data/models/review.dart';
import 'package:nectar/data/services/firebase_firestore_service.dart';

class StoreDetailsRepository {
  final FirebaseFirestoreService _firebaseFirestoreService =
      FirebaseFirestoreService();

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
}
