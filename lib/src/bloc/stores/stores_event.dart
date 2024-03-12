part of 'stores_bloc.dart';

abstract class StoresEvent extends Equatable {
  const StoresEvent();

  @override
  List<Object> get props => [];
}

class FetchStoresWithPagination extends StoresEvent {
  final DocumentSnapshot? lastDocument;
  const FetchStoresWithPagination(this.lastDocument);
}
