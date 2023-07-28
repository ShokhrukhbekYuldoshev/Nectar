part of 'shop_bloc.dart';

abstract class ShopState extends Equatable {
  const ShopState();

  @override
  List<Object> get props => [];
}

class ShopInitial extends ShopState {}

class ShopLoading extends ShopState {}

class ShopLoaded extends ShopState {
  final List<Product> exclusiveProducts;
  final List<Product> bestSellingProducts;
  final List<Store> stores;

  const ShopLoaded({
    required this.exclusiveProducts,
    required this.bestSellingProducts,
    required this.stores,
  });

  @override
  List<Object> get props => [exclusiveProducts, bestSellingProducts, stores];
}

class ShopFailure extends ShopState {
  final String message;

  const ShopFailure({required this.message});

  @override
  List<Object> get props => [message];
}
