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

  List<SearchModel> searchModel = List();

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
    }
  }

  Stream<SearchState> _mapSearchFoodEvent(SearchFoodEvent event) async* {
    try {
      final response = await searchRepository.foods(event.name);

      if (response.hasException) {
        if (response.exception.graphqlErrors[0].message ==
            Errors.TokenExpired) {
          yield SearchTokenExpiredState();
        } else {
          yield SearchConnectionFailedState();
        }
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

  Stream<SearchState> _mapSearchRefreshTokenEvent(
      SearchRefreshTokenEvent event) async* {
    try {
      SecureStorage secureStorage;
      String refreshToken = await secureStorage.read(key: "refreshToken");
      final response = await userRepository.refreshToken(refreshToken);
      if (response.hasException) {
        yield SearchConnectionFailedState();
      } else {
        yield SearchRefreshedTokenState();
      }
    } catch (error) {
      yield SearchConnectionFailedState();
    }
  }
}
