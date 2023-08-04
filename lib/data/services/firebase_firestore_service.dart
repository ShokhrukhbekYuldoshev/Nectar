import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFirestoreService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<QuerySnapshot> getCollection(String collection) async {
    return await _firebaseFirestore.collection(collection).get();
  }

  Future<QuerySnapshot> getCollectionWithPagination({
    required String collection,
    int limit = 10,
    DocumentSnapshot? documentSnapshot,
  }) async {
    if (documentSnapshot == null) {
      return await _firebaseFirestore.collection(collection).limit(limit).get();
    } else {
      return await _firebaseFirestore
          .collection(collection)
          .limit(limit)
          .startAfterDocument(documentSnapshot)
          .get();
    }
  }

  Future<DocumentSnapshot> getDocument({
    required String collection,
    required String documentId,
  }) async {
    return await _firebaseFirestore
        .collection(collection)
        .doc(documentId)
        .get();
  }

  // get document from collection where field == value
  Future<QuerySnapshot> getDocumentsWithQuery(
    String collection,
    Object field,
    Object? value,
  ) async {
    return await _firebaseFirestore
        .collection(collection)
        .where(field, isEqualTo: value)
        .get();
  }

  // multiple queries
  Future<QuerySnapshot> getDocumentsWithMultipleQueries(
    String collection,
    List<Map<String, dynamic>> where,
  ) async {
    Query query = _firebaseFirestore.collection(collection);
    for (var item in where) {
      query = query.where(item['field'], isEqualTo: item['value']);
    }
    return await query.get();
  }

  Future<void> addDocument(
    String collection,
    Map<String, dynamic> data,
  ) async {
    await _firebaseFirestore.collection(collection).add(data);
  }

  Future<void> addMultipleDocuments({
    required String collection,
    required List<Map<String, dynamic>> data,
  }) async {
    final WriteBatch batch = _firebaseFirestore.batch();
    for (var item in data) {
      batch.set(
        _firebaseFirestore.collection(collection).doc(),
        item,
      );
    }
    await batch.commit();
  }

  Future<void> updateDocument(
    String collection,
    String documentId,
    Map<String, dynamic> data,
  ) async {
    await _firebaseFirestore
        .collection(collection)
        .doc(documentId)
        .update(data);
  }

  // update document with query
  Future<void> updateDocumentWithQuery({
    required String collection,
    required Object field,
    required Object value,
    required Map<String, dynamic> data,
  }) async {
    final QuerySnapshot querySnapshot = await _firebaseFirestore
        .collection(collection)
        .where(field, isEqualTo: value)
        .get();
    final List<QueryDocumentSnapshot> queryDocumentSnapshot =
        querySnapshot.docs;
    await _firebaseFirestore
        .collection(collection)
        .doc(queryDocumentSnapshot[0].id)
        .update(data);
  }

  Future<void> deleteDocument({
    required String collection,
    required String documentId,
  }) async {
    await _firebaseFirestore.collection(collection).doc(documentId).delete();
  }

  // get reference from collection where field == value
  Future<DocumentReference> getDocumentReference({
    required String collection,
    required Object field,
    required Object value,
  }) async {
    final QuerySnapshot querySnapshot = await _firebaseFirestore
        .collection(collection)
        .where(field, isEqualTo: value)
        .get();
    final List<QueryDocumentSnapshot> queryDocumentSnapshot =
        querySnapshot.docs;
    return queryDocumentSnapshot[0].reference;
  }

  // get with pagination and query
  Future<QuerySnapshot> getCollectionWithPaginationAndQuery({
    required String collection,
    int limit = 10,
    DocumentSnapshot? documentSnapshot,
    required Object field,
    required Object value,
  }) async {
    if (documentSnapshot == null) {
      return await _firebaseFirestore
          .collection(collection)
          .where(field, isEqualTo: value)
          .limit(limit)
          .get();
    } else {
      return await _firebaseFirestore
          .collection(collection)
          .where(field, isEqualTo: value)
          .limit(limit)
          .startAfterDocument(documentSnapshot)
          .get();
    }
  }

  // get with pagination and order by
  Future<QuerySnapshot> getCollectionWithPaginationAndOrderBy({
    required String collection,
    int limit = 10,
    DocumentSnapshot? documentSnapshot,
    required String field,
    bool descending = false,
  }) async {
    if (documentSnapshot == null) {
      return await _firebaseFirestore
          .collection(collection)
          .orderBy(field, descending: descending)
          .limit(limit)
          .get();
    } else {
      return await _firebaseFirestore
          .collection(collection)
          .orderBy(field, descending: descending)
          .limit(limit)
          .startAfterDocument(documentSnapshot)
          .get();
    }
  }
}
