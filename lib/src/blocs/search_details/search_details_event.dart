part of 'search_details_bloc.dart';

abstract class SearchDetailsEvent extends Equatable {
  const SearchDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchSearchDetailEvent extends SearchDetailsEvent {
  final String id;

  FetchSearchDetailEvent(this.id);
}

class SearchDetailRefreshTokenEvent extends SearchDetailsEvent {
  final SearchDetailsEvent childEvent;

  SearchDetailRefreshTokenEvent(this.childEvent);
}
