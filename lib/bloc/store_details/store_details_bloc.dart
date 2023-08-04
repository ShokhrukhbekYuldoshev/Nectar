import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nectar/data/models/product.dart';
import 'package:nectar/data/models/review.dart';
import 'package:nectar/data/repositories/store_details_repository.dart';

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
      } catch (e) {
        emit(StoreDetailsError(e.toString()));
      }
    });
  }
}
