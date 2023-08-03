import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nectar/data/models/product.dart';
import 'package:nectar/data/repositories/products_repository.dart';

part 'category_products_event.dart';
part 'category_products_state.dart';

class CategoryProductsBloc
    extends Bloc<CategoryProductsEvent, CategoryProductsState> {
  CategoryProductsBloc() : super(CategoryProductsInitial()) {
    final productsRepository = CategoryProductsRepository();
    on<FetchCategoryProducts>((event, emit) async {
      emit(CategoryProductsLoading());
      try {
        final products = await productsRepository.getProducts(event.categoryId);
        emit(CategoryProductsLoaded(products: products));
      } catch (e) {
        emit(CategoryProductsError(message: e.toString()));
      }
    });
  }
}
