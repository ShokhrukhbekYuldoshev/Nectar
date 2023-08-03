import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nectar/data/models/product.dart';
import 'package:nectar/data/services/firebase_firestore_service.dart';

class CategoryProductsRepository {
  final FirebaseFirestoreService _firebaseFirestoreService =
      FirebaseFirestoreService();

  Future<List<Product>> getProducts(String categoryId) async {
    final categoryRef =
        FirebaseFirestore.instance.collection('categories').doc(categoryId);

    final snapshot = await _firebaseFirestoreService.getDocumentsWithQuery(
      'products',
      'category',
      categoryRef,
    );

    return snapshot.docs
        .map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>)
            .copyWith(id: doc.id)) // set the product ID to the document ID)
        .toList();
  }
}
