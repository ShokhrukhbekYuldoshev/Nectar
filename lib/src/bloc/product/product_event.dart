part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

// update cart
class UpdateCart extends ProductEvent {
  final OrderProduct orderProduct;
  final num quantity;

  const UpdateCart({
    required this.orderProduct,
    required this.quantity,
  });

  @override
  List<Object> get props => [orderProduct, quantity];
}

// update favorite
class UpdateFavorite extends ProductEvent {
  final Product product;
  final bool isFavorite;

  const UpdateFavorite({
    required this.product,
    required this.isFavorite,
  });

  @override
  List<Object> get props => [product, isFavorite];
}
