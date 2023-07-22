import 'dart:convert';

import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final String country;
  final String city;
  final String street;

  const Address({
    required this.country,
    required this.city,
    required this.street,
  });

  Address copyWith({
    String? country,
    String? city,
    String? street,
  }) {
    return Address(
      country: country ?? this.country,
      city: city ?? this.city,
      street: street ?? this.street,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'country': country,
      'city': city,
      'street': street,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      country: map['country'] as String,
      city: map['city'] as String,
      street: map['street'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [country, city, street];
}
