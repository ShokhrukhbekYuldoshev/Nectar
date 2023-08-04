import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nectar/data/models/product.dart';
import 'package:nectar/data/models/store.dart';
import 'package:nectar/data/services/firebase_firestore_service.dart';

class ShopRepository {
  final FirebaseFirestoreService _firebaseFirestoreService =
      FirebaseFirestoreService();

  int limit = 10;

  Future<List<Product>> fetchExclusiveProducts() async {
    var snapshot = await _firebaseFirestoreService.getDocumentsWithQuery(
      'products',
      'category',
      null,
    );

    return snapshot.docs
        .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>)
            .copyWith(id: doc.id)) // set the product ID to the document ID
        .toList();
  }

  // best selling products
  Future<List<Product>> fetchBestSellingProducts() async {
    var snapshot = await _firebaseFirestoreService.getDocumentsWithQuery(
      'products',
      'category',
      null,
    );

    return snapshot.docs
        .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>)
            .copyWith(id: doc.id)) // set the product ID to the document ID
        .toList();
  }

  // get stores
  Future<List<Store>> fetchStores(
    DocumentSnapshot? lastSnapshot,
  ) async {
    var snapshot = await _firebaseFirestoreService.getCollectionWithPagination(
      collection: 'stores',
      limit: limit,
      documentSnapshot: lastSnapshot,
    );

    return snapshot.docs
        .map((doc) => Store.fromMap(doc.data() as Map<String, dynamic>)
            .copyWith(id: doc.id))
        .toList();
  }
}
