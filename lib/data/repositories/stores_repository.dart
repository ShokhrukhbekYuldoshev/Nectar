import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nectar/data/models/store.dart';
import 'package:nectar/data/services/firebase_firestore_service.dart';

class StoresRepository {
  final _firestoreService = FirebaseFirestoreService();

  Future<Map<String, dynamic>> getStoresWithPagination(
    DocumentSnapshot? lastDocument,
  ) async {
    final snapshot = await _firestoreService.getCollectionWithPagination(
      collection: 'stores',
      limit: 10,
      documentSnapshot: lastDocument,
    );
    List<Store> stores = snapshot.docs
        .map(
          (e) => Store.fromMap(e.data() as Map<String, dynamic>)
              .copyWith(id: e.id),
        )
        .toList();
    return {
      'stores': stores,
      'lastDocument': snapshot.docs.isNotEmpty ? snapshot.docs.last : null,
    };
  }
}
