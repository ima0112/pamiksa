import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/data/models/models.dart';
import 'package:pamiksa/src/data/repositories/remote/search_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository searchRepository;

  List<SearchModel> searchModel = List();

  SearchBloc(this.searchRepository) : super(SearchInitial());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchFoodEvent) {
      yield* _mapSearchFoodEvent(event);
    }
  }

  Stream<SearchState> _mapSearchFoodEvent(SearchFoodEvent event) async* {
    try {
      final response = await searchRepository.foods(event.name);

      if (response.hasException) {
        print(response.exception);
      } else {
        final List searchData = response.data['searchFood'];

        searchModel = searchData
            .map((e) => SearchModel(id: e['id'], name: e['name']))
            .toList();

        yield FoodsFoundState(searchModel: searchModel);
      }
    } catch (error) {
      print(error.toString());
    }
  }
}
