part of 'stores_bloc.dart';

abstract class StoresState extends Equatable {
  const StoresState();

  @override
  List<Object?> get props => [];
}

class StoresInitial extends StoresState {}

class StoresLoading extends StoresState {}

class StoresLoaded extends StoresState {
  final List<Store> stores;
  final DocumentSnapshot? lastDocument;

  const StoresLoaded({required this.stores, required this.lastDocument});

  @override
  List<Object?> get props => [stores, lastDocument];
}

class StoresError extends StoresState {
  const StoresError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
