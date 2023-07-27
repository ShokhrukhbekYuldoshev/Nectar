import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Address extends Equatable {
  final String country;
  final String city;
  String street;
  final DateTime createdAt;
  final DateTime updatedAt;

  Address({
    required this.country,
    required this.city,
    required this.street,
    required this.createdAt,
    required this.updatedAt,
  });

  Address copyWith({
    String? country,
    String? city,
    String? street,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Address(
      country: country ?? this.country,
      city: city ?? this.city,
      street: street ?? this.street,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'country': country,
      'city': city,
      'street': street,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      country: map['country'] as String,
      city: map['city'] as String,
      street: map['street'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
    );
  }

  factory Address.empty() {
    return Address(
      country: '',
      city: '',
      street: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  String get path => '$country/$city/$street';

  bool get isEmpty => country.isEmpty && city.isEmpty && street.isEmpty;

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [country, city, street, createdAt, updatedAt];
}
