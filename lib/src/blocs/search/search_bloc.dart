import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/data/errors.dart';
import 'package:pamiksa/src/data/models/models.dart';
import 'package:pamiksa/src/data/repositories/repositories.dart';
import 'package:pamiksa/src/data/storage/secure_storage.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository searchRepository;
  final UserRepository userRepository;

  SecureStorage secureStorage = SecureStorage();
  List<SearchModel> searchModel = List();
  List<SuggestionsModel> suggestionsNames = List();

  String name;

  SearchBloc(this.searchRepository, this.userRepository)
      : super(SearchInitial());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchFoodEvent) {
      yield* _mapSearchFoodEvent(event);
    } else if (event is SearchRefreshTokenEvent) {
      yield* _mapSearchRefreshTokenEvent(event);
    } else if (event is SearchSuggestionsEvent) {
      yield* _mapSearchSuggestionsEvent(event);
    }
  }

  Stream<SearchState> _mapSearchFoodEvent(SearchFoodEvent event) async* {
    yield SearchingFoodsState();
    name = event.name;
    try {
      final response = await searchRepository.foods(event.name);

      if (response.hasException) {
        if (response.exception.graphqlErrors[0].message ==
            Errors.TokenExpired) {
          add(SearchRefreshTokenEvent());
        } else {
          yield SearchConnectionFailedState();
        }
      } else {
        final List searchData = response.data['searchFood'];

        searchModel = searchData
            .map((e) => SearchModel(id: e['id'], name: e['name']))
            .toList();

        final suggestion = await searchRepository.getByName(event.name);

        if (suggestion == null) {
          List<SuggestionsModel> suggestionsModel = List();
          suggestionsModel.add(SuggestionsModel(name: event.name));
          suggestionsModel.forEach((element) {
            searchRepository.insert('Search', element.toMap());
          });
        }

        yield FoodsFoundState(searchModel: searchModel);
      }
    } catch (error) {
      print(error.toString());
    }
  }

  Stream<SearchState> _mapSearchRefreshTokenEvent(
      SearchRefreshTokenEvent event) async* {
    try {
      String refreshToken = await secureStorage.read(key: "refreshToken");
      final response = await userRepository.refreshToken(refreshToken);
      if (response.hasException) {
        yield SearchConnectionFailedState();
      } else {
        add(SearchFoodEvent(name));
      }
    } catch (error) {
      yield SearchConnectionFailedState();
    }
  }

  Stream<SearchState> _mapSearchSuggestionsEvent(
      SearchSuggestionsEvent event) async* {
    try {
      final suggestions = await searchRepository.all();
      suggestionsNames =
          suggestions.map((e) => SuggestionsModel(name: e['name'])).toList();

      yield SuggestionsState(suggestions: suggestionsNames);
    } catch (error) {
      yield SearchConnectionFailedState();
    }
  }
}
