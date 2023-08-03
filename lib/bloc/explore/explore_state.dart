part of 'explore_bloc.dart';

abstract class ExploreState extends Equatable {
  const ExploreState();

  @override
  List<Object> get props => [];
}

class ExploreInitial extends ExploreState {}

class ExploreLoading extends ExploreState {}

class ExploreLoaded extends ExploreState {
  final List<Category> categories;

  const ExploreLoaded({
    required this.categories,
  });

  @override
  List<Object> get props => [categories];
}

class ExploreError extends ExploreState {
  final String message;

  const ExploreError({required this.message});

  @override
  List<Object> get props => [message];
}
