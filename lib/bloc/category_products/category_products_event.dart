part of 'category_products_bloc.dart';

abstract class CategoryProductsEvent extends Equatable {
  const CategoryProductsEvent();

  @override
  List<Object> get props => [];
}

class FetchCategoryProducts extends CategoryProductsEvent {
  final String categoryId;

  const FetchCategoryProducts({required this.categoryId});

  @override
  List<Object> get props => [categoryId];
}
