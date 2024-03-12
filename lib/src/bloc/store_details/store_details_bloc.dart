import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nectar/src/data/models/product.dart';
import 'package:nectar/src/data/models/review.dart';
import 'package:nectar/src/data/models/store.dart';
import 'package:nectar/src/data/repositories/store_details_repository.dart';

part 'store_details_event.dart';
part 'store_details_state.dart';

class StoreDetailsBloc extends Bloc<StoreDetailsEvent, StoreDetailsState> {
  StoreDetailsBloc() : super(StoreDetailsInitial()) {
    final storeDetailsRepository = StoreDetailsRepository();
    on<FetchStoreDetailsEvent>((event, emit) async {
      emit(StoreDetailsLoading());
      try {
        final List<Product> products =
            await storeDetailsRepository.getProducts(event.storeId);
        final List<Review> reviews =
            await storeDetailsRepository.getReviews(event.storeId);
        emit(StoreDetailsLoaded(products, reviews));
      } catch (e, s) {
        debugPrintStack(label: e.toString(), stackTrace: s);
        emit(StoreDetailsError(message: e.toString()));
      }
    });
    on<UpdateFavorite>((event, emit) async {
      try {
        emit(StoreDetailsInitial());
        await storeDetailsRepository.updateFavorite(
          event.store,
          event.isFavorite,
        );
        emit(
          StoreDetailsFavoriteUpdated(
            store: event.store,
            isFavorite: event.isFavorite,
          ),
        );
      } catch (e, s) {
        debugPrintStack(label: e.toString(), stackTrace: s);
        emit(StoreDetailsError(message: e.toString()));
      }
    });
  }
}
