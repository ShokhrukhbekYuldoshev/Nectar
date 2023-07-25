import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:nectar/data/models/category.dart';
import 'package:nectar/data/models/unit.dart';

class Product extends Equatable {
  final String name;
  final String? description;
  final double price;
  final Unit unit;
  final List<String>? images;
  final Category? category;
  final String? brand;
  final Map<String, double>? nutritions;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Product({
    required this.name,
    this.description,
    required this.price,
    required this.unit,
    this.images,
    this.category,
    this.brand,
    this.nutritions,
    required this.createdAt,
    required this.updatedAt,
  });

  Product copyWith({
    String? name,
    String? description,
    double? price,
    Unit? unit,
    List<String>? images,
    Category? category,
    String? brand,
    Map<String, double>? nutritions,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Product(
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      unit: unit ?? this.unit,
      images: images ?? this.images,
      category: category ?? this.category,
      brand: brand ?? this.brand,
      nutritions: nutritions ?? this.nutritions,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'price': price,
      'unit': unit,
      'images': images,
      'category': category,
      'brand': brand,
      'nutritions': nutritions,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
      price: map['price'] as double,
      unit: Unit.fromMap(map['unit'] as Map<String, dynamic>),
      images: map['images'] != null
          ? List<String>.from((map['images'] as List<String>))
          : null,
      category: map['category'] != null
          ? Category.fromMap(map['category'] as Map<String, dynamic>)
          : null,
      brand: map['brand'] != null ? map['brand'] as String : null,
      nutritions: map['nutritions'] != null
          ? Map<String, double>.from((map['nutritions'] as Map<String, double>))
          : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      name,
      description,
      price,
      unit,
      images,
      category,
      brand,
      nutritions,
      createdAt,
      updatedAt,
    ];
  }
}
