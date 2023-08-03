part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductCartUpdated extends ProductState {
  final OrderProduct product;
  final num quantity;

  const ProductCartUpdated({
    required this.product,
    required this.quantity,
  });

  @override
  List<Object> get props => [product, quantity];
}

class ProductFavoriteUpdated extends ProductState {
  final Product product;
  final bool isFavorite;

  const ProductFavoriteUpdated({
    required this.product,
    required this.isFavorite,
  });

  @override
  List<Object> get props => [product, isFavorite];
}

class ProductError extends ProductState {
  final String message;

  const ProductError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
