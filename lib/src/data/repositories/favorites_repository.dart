import 'package:hive_flutter/hive_flutter.dart';
import 'package:nectar/src/data/models/product.dart';
import 'package:nectar/src/data/models/user.dart' as user_model;
import 'package:nectar/src/data/services/firebase_firestore_service.dart';

class FavoritesRepository {
  // fetch user's favorite products
  Future<List<Product>> fetchFavorites() async {
    final firestore = FirebaseFirestoreService();
    final user_model.User user = Hive.box('myBox').get('user');
    final List? favoriteProducts = user.favoriteProducts; //reference

    // get products from references
    final List<Product> products = [];
    for (var favoriteProduct in favoriteProducts!) {
      final product = await firestore.getDocument(
        collection: 'products',
        documentId: favoriteProduct.id,
      );
      products.add(Product.fromMap(product.data() as Map<String, dynamic>)
          .copyWith(id: product.id));
    }

    return products;
  }
}
