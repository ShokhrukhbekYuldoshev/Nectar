import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:nectar/data/models/address.dart';

class User extends Equatable {
  final String uid;
  final String email;
  final String displayName;
  final String? photoURL;
  final String phoneNumber;
  final Address address;

  const User({
    required this.uid,
    required this.email,
    required this.displayName,
    this.photoURL,
    required this.phoneNumber,
    required this.address,
  });

  User copyWith({
    String? uid,
    String? email,
    String? displayName,
    String? photoURL,
    String? phoneNumber,
    Address? address,
  }) {
    return User(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoURL: photoURL ?? this.photoURL,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
      'phoneNumber': phoneNumber,
      'address': address.toMap(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] as String,
      email: map['email'] as String,
      displayName: map['displayName'] as String,
      photoURL: map['photoURL'] != null ? map['photoURL'] as String : null,
      phoneNumber: map['phoneNumber'] as String,
      address: Address.fromMap(map['address'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        uid,
        email,
        displayName,
        photoURL,
        phoneNumber,
        address,
      ];
}
