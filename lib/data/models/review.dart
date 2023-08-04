import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final String? id;
  final String message;
  final num rating;
  final DocumentReference user;
  final DateTime createdAt;
  final DocumentReference target;

  const Review({
    this.id,
    required this.message,
    required this.rating,
    required this.user,
    required this.createdAt,
    required this.target,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'rating': rating,
      'user': user,
      'createdAt': createdAt,
      'target': target,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      id: map['id'] as String?,
      message: map['message'] as String,
      rating: map['rating'] as num,
      user: map['user'] as DocumentReference,
      createdAt: map['createdAt'] as DateTime,
      target: map['target'] as DocumentReference,
    );
  }

  Review copyWith({
    String? id,
    String? message,
    num? rating,
    DocumentReference? user,
    DateTime? createdAt,
    DocumentReference? target,
  }) {
    return Review(
      id: id ?? this.id,
      message: message ?? this.message,
      rating: rating ?? this.rating,
      user: user ?? this.user,
      createdAt: createdAt ?? this.createdAt,
      target: target ?? this.target,
    );
  }

  @override
  List<Object?> get props => [
        id,
        message,
        rating,
        user,
        createdAt,
        target,
      ];
}
