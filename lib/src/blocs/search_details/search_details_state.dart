part of 'search_details_bloc.dart';

abstract class SearchDetailsState extends Equatable {
  const SearchDetailsState();

  @override
  List<Object> get props => [];
}

class SearchDetailsInitial extends SearchDetailsState {}

class LoadingSearchDetailsState extends SearchDetailsState {}

class LoadedSearchDetailsState extends SearchDetailsState {
  final int count;
  final SearchModel searchModel;
  final List<AddonsModel> addonsModel;

  LoadedSearchDetailsState({this.addonsModel, this.count, this.searchModel});
}

class LoadedSearchDetailWithOutAddonsState extends SearchDetailsState {
  final SearchModel searchModel;
  final List<AddonsModel> addonsModel;

  LoadedSearchDetailWithOutAddonsState({this.addonsModel, this.searchModel});
}

class SearchDetailsTokenExpiredState extends SearchDetailsState {}

class SearchDetailsConnectionFailedState extends SearchDetailsState {}
