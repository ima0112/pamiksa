part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchingFoodsState extends SearchState {}

class FoodsFoundState extends SearchState {
  final List<SearchModel> searchModel;

  FoodsFoundState({this.searchModel});
}
