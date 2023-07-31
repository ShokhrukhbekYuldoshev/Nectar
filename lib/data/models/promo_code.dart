import 'dart:convert';

import 'package:equatable/equatable.dart';

class PromoCode extends Equatable {
  final String code;
  final String description;
  final double discount;

  const PromoCode({
    required this.code,
    required this.description,
    required this.discount,
  });

  @override
  List<Object> get props => [code, description, discount];

  PromoCode copyWith({
    String? code,
    String? description,
    double? discount,
  }) {
    return PromoCode(
      code: code ?? this.code,
      description: description ?? this.description,
      discount: discount ?? this.discount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'description': description,
      'discount': discount,
    };
  }

  factory PromoCode.fromMap(Map<String, dynamic> map) {
    return PromoCode(
      code: map['code'] as String,
      description: map['description'] as String,
      discount: map['discount'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory PromoCode.fromJson(String source) =>
      PromoCode.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
