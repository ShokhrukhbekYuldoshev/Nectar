import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:nectar/src/data/models/store.dart';
import 'package:nectar/src/data/repositories/stores_repository.dart';

part 'stores_event.dart';
part 'stores_state.dart';

class StoresBloc extends Bloc<StoresEvent, StoresState> {
  StoresBloc() : super(StoresInitial()) {
    final storesRepository = StoresRepository();
    on<FetchStoresWithPagination>((event, emit) async {
      emit(StoresLoading());
      try {
        final map = await storesRepository.getStoresWithPagination(
          event.lastDocument,
        );
        emit(StoresLoaded(
          stores: map['stores'] as List<Store>,
          lastDocument: map['lastDocument'] as DocumentSnapshot?,
        ));
      } catch (e) {
        emit(StoresError(e.toString()));
      }
    });
  }
}
