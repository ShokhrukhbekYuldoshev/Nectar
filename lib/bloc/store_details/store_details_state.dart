part of 'store_details_bloc.dart';

abstract class StoreDetailsState extends Equatable {
  const StoreDetailsState();

  @override
  List<Object> get props => [];
}

class StoreDetailsInitial extends StoreDetailsState {}

class StoreDetailsLoading extends StoreDetailsState {}

class StoreDetailsLoaded extends StoreDetailsState {
  final List<Product> products;
  final List<Review> reviews;

  const StoreDetailsLoaded(this.products, this.reviews);

  @override
  List<Object> get props => [products, reviews];
}

class StoreDetailsError extends StoreDetailsState {
  final String message;

  const StoreDetailsError(this.message);

  @override
  List<Object> get props => [message];
}
