import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nectar/data/enums/unit.dart';
import 'package:nectar/data/models/address.dart';
import 'package:nectar/data/models/category.dart';
import 'package:nectar/data/models/order_product.dart';
import 'package:nectar/data/models/product.dart';
import 'package:nectar/data/models/store.dart';
import 'package:nectar/data/models/user.dart';

// register adapters
void registerAdapters() {
  Hive.registerAdapter(FirestoreDocumentReferenceAdapter());
  Hive.registerAdapter(AddressAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(StoreAdapter());
  Hive.registerAdapter(OrderProductAdapter());
}

class FirestoreDocumentReferenceAdapter extends TypeAdapter<DocumentReference> {
  @override
  final int typeId = 0;

  @override
  DocumentReference read(BinaryReader reader) {
    return FirebaseFirestore.instance.doc(reader.read());
  }

  @override
  void write(BinaryWriter writer, DocumentReference obj) {
    writer.write(obj.path);
  }
}

class AddressAdapter extends TypeAdapter<Address> {
  @override
  final int typeId = 1;

  @override
  Address read(BinaryReader reader) {
    return Address(
      country: reader.read(),
      city: reader.read(),
      street: reader.read(),
      createdAt: reader.read(),
      updatedAt: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Address obj) {
    writer.write(obj.country);
    writer.write(obj.city);
    writer.write(obj.street);
    writer.write(obj.createdAt);
    writer.write(obj.updatedAt);
  }
}

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 2;

  @override
  User read(BinaryReader reader) {
    return User(
      uid: reader.read(),
      email: reader.read(),
      displayName: reader.read(),
      photoUrl: reader.read(),
      phoneNumber: reader.read(),
      address: reader.read(),
      favoriteProducts: reader.read(),
      createdAt: reader.read(),
      updatedAt: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer.write(obj.uid);
    writer.write(obj.email);
    writer.write(obj.displayName);
    writer.write(obj.photoUrl);
    writer.write(obj.phoneNumber);
    writer.write(obj.address);
    writer.write(obj.favoriteProducts);
    writer.write(obj.createdAt);
    writer.write(obj.updatedAt);
  }
}

class CategoryAdapter extends TypeAdapter<Category> {
  @override
  final int typeId = 3;

  @override
  Category read(BinaryReader reader) {
    return Category(
      name: reader.read(),
      description: reader.read(),
      image: reader.read(),
      createdAt: reader.read(),
      updatedAt: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Category obj) {
    writer.write(obj.name);
    writer.write(obj.description);
    writer.write(obj.image);
    writer.write(obj.createdAt);
    writer.write(obj.updatedAt);
  }
}

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 5;

  @override
  Product read(BinaryReader reader) {
    return Product(
      name: reader.read(),
      store: reader.read(),
      description: reader.read(),
      price: reader.read(),
      unit: unitFromName(reader.read()),
      images: reader.read(),
      category: reader.read(),
      brand: reader.read(),
      nutritions: reader.read(),
      createdAt: reader.read(),
      updatedAt: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer.write(obj.name);
    writer.write(obj.store);
    writer.write(obj.description);
    writer.write(obj.price);
    writer.write(obj.unit.name);
    writer.write(obj.images);
    writer.write(obj.category);
    writer.write(obj.brand);
    writer.write(obj.nutritions);
    writer.write(obj.createdAt);
    writer.write(obj.updatedAt);
  }
}

class StoreAdapter extends TypeAdapter<Store> {
  @override
  final int typeId = 4;

  @override
  Store read(BinaryReader reader) {
    return Store(
      name: reader.read(),
      latitude: reader.read(),
      longitude: reader.read(),
      description: reader.read(),
      image: reader.read(),
      createdAt: reader.read(),
      updatedAt: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Store obj) {
    writer.write(obj.name);
    writer.write(obj.latitude);
    writer.write(obj.longitude);
    writer.write(obj.description);
    writer.write(obj.image);
    writer.write(obj.createdAt);
    writer.write(obj.updatedAt);
  }
}

class OrderProductAdapter extends TypeAdapter<OrderProduct> {
  @override
  final int typeId = 6;

  @override
  OrderProduct read(BinaryReader reader) {
    return OrderProduct(
      product: reader.read(),
      quantity: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, OrderProduct obj) {
    writer.write(obj.product);
    writer.write(obj.quantity);
  }
}
