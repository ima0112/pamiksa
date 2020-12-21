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

class SearchSuggestionsEvent extends SearchEvent {
  final String query;

  SearchSuggestionsEvent(this.query);
}

class DeleteSuggestionsEvent extends SearchEvent {
  final int id;

  DeleteSuggestionsEvent(this.id);
}

class SearchRefreshTokenEvent extends SearchEvent {
  final SearchEvent childEvent;

  SearchRefreshTokenEvent(this.childEvent);
}

class SetInitialSearchEvent extends SearchEvent {}
