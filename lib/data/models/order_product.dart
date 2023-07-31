import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:nectar/data/models/product.dart';

// ignore: must_be_immutable
class OrderProduct extends Equatable {
  final Product product;
  int quantity;
  OrderProduct({
    required this.product,
    required this.quantity,
  });

  OrderProduct copyWith({
    Product? product,
    int? quantity,
  }) {
    return OrderProduct(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': product.toMap(),
      'quantity': quantity,
    };
  }

  factory OrderProduct.fromMap(Map<String, dynamic> map) {
    return OrderProduct(
      product: Product.fromMap(map['product'] as Map<String, dynamic>),
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderProduct.fromJson(String source) =>
      OrderProduct.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'OrderProduct(product: $product, quantity: $quantity)';

  @override
  bool operator ==(covariant OrderProduct other) {
    if (identical(this, other)) return true;

    return other.product == product && other.quantity == quantity;
  }

  @override
  int get hashCode => product.hashCode;

  @override
  List<Object?> get props => [product];
}
