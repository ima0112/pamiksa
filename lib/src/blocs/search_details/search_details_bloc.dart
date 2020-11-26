import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/data/errors.dart';
import 'package:pamiksa/src/data/models/models.dart';
import 'package:pamiksa/src/data/models/search.dart';
import 'package:pamiksa/src/data/repositories/remote/remote_repository.dart';
import 'package:pamiksa/src/data/storage/secure_storage.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';

part 'search_details_event.dart';
part 'search_details_state.dart';

class SearchDetailsBloc extends Bloc<SearchDetailsEvent, SearchDetailsState> {
  final SearchRepository searchRepository;
  final AddonsRepository addonsRepository;
  final UserRepository userRepository;
  final NavigationService navigationService = locator<NavigationService>();

  SecureStorage secureStorage = SecureStorage();
  List<AddonsModel> addonsModel = List();

  String id;

  SearchDetailsBloc(
      this.addonsRepository, this.userRepository, this.searchRepository)
      : super(SearchDetailsInitial());

  @override
  Stream<SearchDetailsState> mapEventToState(
    SearchDetailsEvent event,
  ) async* {
    if (event is FetchSearchDetailEvent) {
      yield* _mapFetchSearchDetailEvent(event);
    } else if (event is SearchDetailRefreshTokenEvent) {
      yield* _mapSearchDetailRefreshTokenEvent(event);
    }
  }

  Stream<SearchDetailsState> _mapFetchSearchDetailEvent(
      FetchSearchDetailEvent event) async* {
    yield LoadingSearchDetailsState();
    id = event.id;
    try {
      SearchModel result = await searchRepository.getById(id);
      final response = await addonsRepository.addons(id);

      if (response.hasException) {
        if (response.exception.graphqlErrors[0].message ==
            Errors.TokenExpired) {
          add(SearchDetailRefreshTokenEvent(event));
        } else {
          yield SearchDetailsConnectionFailedState();
        }
      } else {
        final List addonsData = response.data['addOns'] ?? null;

        if (addonsData != null) {
          addonsModel = addonsData
              .map((e) =>
                  AddonsModel(id: e['id'], name: e['name'], price: e['price']))
              .toList();

          addonsRepository.clear();
          addonsModel.forEach((element) {
            addonsRepository.insert('Addons', element.toMap());
          });
          yield LoadedSearchDetailsState(
              addonsModel: addonsModel,
              count: addonsModel.length,
              searchModel: result);
        } else {
          yield LoadedSearchDetailWithOutAddonsState(
              addonsModel: addonsModel, searchModel: result);
        }
      }
    } catch (error) {
      SearchDetailsConnectionFailedState();
    }
  }

  Stream<SearchDetailsState> _mapSearchDetailRefreshTokenEvent(
      SearchDetailRefreshTokenEvent event) async* {
    try {
      String refreshToken = await secureStorage.read(key: "refreshToken");

      final response = await userRepository.refreshToken(refreshToken);

      if (response.hasException &&
          response.exception.graphqlErrors[0].message ==
              Errors.RefreshTokenExpired) {
        await navigationService.navigateWithoutGoBack(Routes.LoginRoute);
      } else if (response.hasException) {
        yield SearchDetailsConnectionFailedState();
      } else {
        add(event.childEvent);
      }
    } catch (error) {
      yield SearchDetailsConnectionFailedState();
    }
  }
}
