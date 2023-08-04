import 'package:equatable/equatable.dart';

class Store extends Equatable {
  final String? id;
  final String name;
  final String? description;
  final String? image;
  final DateTime createdAt;
  final DateTime updatedAt;
  final num latitude;
  final num longitude;

  const Store({
    this.id,
    required this.name,
    this.description,
    this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.latitude,
    required this.longitude,
  });

  Store copyWith({
    String? id,
    String? name,
    String? description,
    String? image,
    DateTime? createdAt,
    DateTime? updatedAt,
    num? latitude,
    num? longitude,
  }) {
    return Store(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'image': image,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Store.fromMap(Map<String, dynamic> map) {
    return Store(
      name: map['name'] as String,
      description: map['description'],
      image: map['image'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
      latitude: map['latitude'] as num,
      longitude: map['longitude'] as num,
    );
  }

  factory Store.empty() {
    return Store(
      id: null,
      name: '',
      description: '',
      image: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      latitude: 0.0,
      longitude: 0.0,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        image,
        createdAt,
        updatedAt,
        latitude,
        longitude,
      ];
}
