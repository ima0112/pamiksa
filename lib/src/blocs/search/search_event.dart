part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchFoodEvent extends SearchEvent {
  final String name;

  SearchFoodEvent(this.name);
}

class SearchRefreshTokenEvent extends SearchEvent {}
