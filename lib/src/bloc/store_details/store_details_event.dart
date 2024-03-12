part of 'store_details_bloc.dart';

abstract class StoreDetailsEvent extends Equatable {
  const StoreDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchStoreDetailsEvent extends StoreDetailsEvent {
  final String storeId;

  const FetchStoreDetailsEvent(this.storeId);

  @override
  List<Object> get props => [storeId];
}

// update favorite
class UpdateFavorite extends StoreDetailsEvent {
  final Store store;
  final bool isFavorite;

  const UpdateFavorite({
    required this.store,
    required this.isFavorite,
  });

  @override
  List<Object> get props => [store, isFavorite];
}
