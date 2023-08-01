import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nectar/data/models/order_product.dart';
import 'package:nectar/data/models/product.dart';
import 'package:nectar/data/models/user.dart' as user_model;
import 'package:nectar/data/services/firebase_firestore_service.dart';

class ProductRepository {
  final _firestore = FirebaseFirestoreService();
  static final List<OrderProduct> cart = [];
  static var box = Hive.box('myBox');

  // load cart from hive
  static void loadCart() {
    if (box.containsKey('cart')) {
      final List<OrderProduct> hiveCart =
          List<OrderProduct>.from(box.get('cart'));
      cart.clear();
      for (OrderProduct item in hiveCart) {
        cart.add(item);
      }
    }
  }

  // get product quantity in cart
  static int getQuantity(Product product) {
    for (OrderProduct item in cart) {
      if (item.product == product) {
        return item.quantity;
      }
    }
    return 0;
  }

  // get total price of cart
  static double getTotalPrice() {
    double total = 0;
    for (OrderProduct item in cart) {
      total += item.product.price * item.quantity;
    }
    return total;
  }

  // update cart in hive
  Future<void> updateHive() async {
    await box.put('cart', cart);
  }

  // update cart
  Future<void> updateCart(OrderProduct product, int quantity) async {
    // guard clause
    if (quantity < 0) return;

    // check if product already in cart
    if (cart.contains(product)) {
      // update quantity
      cart[cart.indexOf(product)].quantity = quantity;

      // remove if quantity is 0
      if (quantity == 0) {
        cart.remove(product);
      }
    } else {
      // add to cart
      product.quantity = quantity;
      cart.add(product);
    }
    await updateHive();
  }

  static bool isFavorite(Product product) {
    // get user
    user_model.User user = box.get("user");

    // initialize favoriteProducts if null
    user.favoriteProducts ??= [];
    print(user.favoriteProducts);
    // check if product is in favorite
    return user.favoriteProducts?.contains(
          FirebaseFirestore.instance.collection('products').doc(product.id),
        ) ??
        false;
  }

  // update favorite
  Future<void> updateFavorite(Product product, bool isFavorite) async {
    // document reference
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('products').doc(product.id);

    // get user
    user_model.User user = box.get("user");

    // initialize favoriteProducts if null
    user.favoriteProducts ??= [];

    // add or remove from favorite
    if (isFavorite) {
      user.favoriteProducts?.add(documentReference);
    } else {
      user.favoriteProducts?.remove(documentReference);
    }

    // update in hive
    await box.put('user', user);

    // update in firestore
    await _firestore.updateDocumentWithQuery("users", "uid", user.uid, {
      "favoriteProducts": user.favoriteProducts,
    });
  }
}
