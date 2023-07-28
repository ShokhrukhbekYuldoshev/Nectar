import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nectar/data/models/product.dart';
import 'package:nectar/data/models/store.dart';
import 'package:nectar/data/repositories/shop_repository.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopBloc() : super(ShopInitial()) {
    final shopRepository = ShopRepository();
    on<FetchShopScreenData>((event, emit) async {
      emit(ShopLoading());
      try {
        final exclusiveProducts = await shopRepository.fetchExclusiveProducts();
        final bestSellingProducts =
            await shopRepository.fetchBestSellingProducts();
        final stores = await shopRepository.fetchStores(null);
        emit(
          ShopLoaded(
            exclusiveProducts: exclusiveProducts,
            bestSellingProducts: bestSellingProducts,
            stores: stores,
          ),
        );
      } catch (e, s) {
        debugPrintStack(label: e.toString(), stackTrace: s);
        emit(ShopFailure(message: e.toString()));
      }
    });
  }
}
