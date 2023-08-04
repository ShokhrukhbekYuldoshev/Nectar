import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:nectar/data/models/product.dart';
import 'package:nectar/data/repositories/search_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    final searchRepository = SearchRepository();
    on<SearchProducts>((event, emit) async {
      emit(SearchLoading());
      try {
        final products = await searchRepository.searchProducts(event.query);
        emit(SearchLoaded(products: products));
      } catch (e, s) {
        debugPrintStack(label: e.toString(), stackTrace: s);
        emit(SearchError(message: e.toString()));
      }
    });
  }
}
