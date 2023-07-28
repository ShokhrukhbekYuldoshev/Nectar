import 'package:equatable/equatable.dart';

class Store extends Equatable {
  final String name;
  final String? description;
  final String? image;
  final DateTime createdAt;
  final DateTime updatedAt;
  final double latitude;
  final double longitude;

  const Store({
    required this.name,
    this.description,
    this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.latitude,
    required this.longitude,
  });

  Store copyWith({
    String? name,
    String? description,
    String? image,
    DateTime? createdAt,
    DateTime? updatedAt,
    double? latitude,
    double? longitude,
  }) {
    return Store(
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
      description: map['description'] as String,
      image: map['image'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
    );
  }

  factory Store.empty() {
    return Store(
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
        name,
        description,
        image,
        createdAt,
        updatedAt,
        latitude,
        longitude,
      ];
}
