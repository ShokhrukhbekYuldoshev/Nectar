part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchProducts extends SearchEvent {
  final String query;

  const SearchProducts({required this.query});

  @override
  List<Object> get props => [query];
}
