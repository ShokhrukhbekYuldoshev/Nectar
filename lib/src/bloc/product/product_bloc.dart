import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:nectar/src/data/models/order_product.dart';
import 'package:nectar/src/data/models/product.dart';
import 'package:nectar/src/data/repositories/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository = ProductRepository();
  ProductBloc() : super(ProductInitial()) {
    on<UpdateCart>((event, emit) async {
      try {
        emit(ProductInitial());
        await _productRepository.updateCart(
          event.orderProduct,
          event.quantity,
        );
        emit(
          ProductCartUpdated(
            product: event.orderProduct,
            quantity: event.quantity,
          ),
        );
      } catch (e, s) {
        debugPrintStack(label: e.toString(), stackTrace: s);
        emit(ProductError(message: e.toString()));
      }
    });
    on<UpdateFavorite>((event, emit) async {
      try {
        emit(ProductInitial());
        await _productRepository.updateFavorite(
          event.product,
          event.isFavorite,
        );
        emit(
          ProductFavoriteUpdated(
            product: event.product,
            isFavorite: event.isFavorite,
          ),
        );
      } catch (e, s) {
        debugPrintStack(label: e.toString(), stackTrace: s);
        emit(ProductError(message: e.toString()));
      }
    });
  }
}
