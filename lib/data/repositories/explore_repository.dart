import 'package:nectar/data/models/category.dart';
import 'package:nectar/data/services/firebase_firestore_service.dart';

class ExploreRepository {
  final FirebaseFirestoreService _firebaseFirestoreService =
      FirebaseFirestoreService();

  Future<List<Category>> getCategories() async {
    final snapshot =
        await _firebaseFirestoreService.getCollection('categories');

    return snapshot.docs
        .map((doc) => Category.fromMap(doc.data() as Map<String, dynamic>)
            .copyWith(id: doc.id))
        .toList();
  }
}
