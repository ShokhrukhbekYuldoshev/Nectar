import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:nectar/data/models/address.dart';

// ignore: must_be_immutable
class User extends Equatable {
  final String uid;
  final String email;
  final String displayName;
  final String? photoUrl;
  String phoneNumber;
  Address address;
  List<dynamic>? favoriteProducts;
  List<dynamic>? favoriteStores;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.uid,
    required this.email,
    required this.displayName,
    this.photoUrl,
    required this.phoneNumber,
    required this.address,
    this.favoriteProducts,
    this.favoriteStores,
    required this.createdAt,
    required this.updatedAt,
  });

  User copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? photoURL,
    String? phoneNumber,
    Address? address,
    List<DocumentReference>? favoriteProducts,
    List<DocumentReference>? favoriteStores,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoURL,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      favoriteProducts: favoriteProducts ?? this.favoriteProducts,
      favoriteStores: favoriteStores ?? this.favoriteStores,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoURL': photoUrl,
      'phoneNumber': phoneNumber,
      'address': address.toMap(),
      'favoriteProducts': favoriteProducts,
      'favoriteStores': favoriteStores,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] as String,
      email: map['email'] as String,
      displayName: map['displayName'] as String,
      photoUrl: map['photoURL'] != null ? map['photoURL'] as String : null,
      phoneNumber: map['phoneNumber'] as String,
      address: Address.fromMap(map['address'] as Map<String, dynamic>),
      favoriteProducts: map['favoriteProducts'] != null
          ? List<DocumentReference>.from(
              map['favoriteProducts']?.map(
                (x) => x,
              ),
            )
          : null,
      favoriteStores: map['favoriteStores'] != null
          ? List<DocumentReference>.from(
              map['favoriteStores']?.map(
                (x) => x,
              ),
            )
          : null,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        uid,
        email,
        displayName,
        photoUrl,
        phoneNumber,
        address,
        favoriteProducts,
        favoriteStores,
        createdAt,
        updatedAt,
      ];
}
