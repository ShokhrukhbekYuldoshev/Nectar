import 'dart:convert';

import 'package:equatable/equatable.dart';

class Unit extends Equatable {
  // product unit: kg, g, l, ml, etc.
  final String name;
  final String symbol;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Unit({
    required this.name,
    required this.symbol,
    required this.createdAt,
    required this.updatedAt,
  });

  Unit copyWith({
    String? name,
    String? symbol,
  }) {
    return Unit(
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'symbol': symbol,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory Unit.fromMap(Map<String, dynamic> map) {
    return Unit(
      name: map['name'] as String,
      symbol: map['symbol'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Unit.fromJson(String source) =>
      Unit.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [name, symbol, createdAt, updatedAt];
}
