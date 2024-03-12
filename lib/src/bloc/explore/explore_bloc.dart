import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nectar/src/data/models/category.dart';

import 'package:nectar/src/data/repositories/explore_repository.dart';

part 'explore_event.dart';
part 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ExploreBloc() : super(ExploreInitial()) {
    final exploreRepository = ExploreRepository();
    on<FetchCategories>((event, emit) async {
      emit(ExploreLoading());
      try {
        final categories = await exploreRepository.getCategories();
        emit(ExploreLoaded(categories: categories));
      } catch (e) {
        emit(ExploreError(message: e.toString()));
      }
    });
  }
}
