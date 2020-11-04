import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/data/models/addons.dart';
import 'package:pamiksa/src/data/repositories/remote/addons_repository.dart';

part 'addons_event.dart';
part 'addons_state.dart';

class AddonsBloc extends Bloc<AddonsEvent, AddonsState> {
  final AddonsRepository addonsRepository;

  List<AddonsModel> addonsModel = List();

  AddonsBloc(this.addonsRepository) : super(AddonsInitial());

  @override
  Stream<AddonsState> mapEventToState(
    AddonsEvent event,
  ) async* {
    if (event is FetchAddonsEvent) {
      yield* _mapFetchAddonsEvent(event);
    }
  }

  Stream<AddonsState> _mapFetchAddonsEvent(FetchAddonsEvent event) async* {
    yield LoadingAddonssState();
    try {
      final response = await addonsRepository.addons(event.id);
      final List addonsData = response.data['addOns'];

      addonsModel = addonsData
          .map((e) =>
              AddonsModel(id: e['id'], name: e['name'], price: e['price']))
          .toList();

      addonsRepository.clear();
      addonsModel.forEach((element) {
        addonsRepository.insert('Addons', element.toMap());
      });

      if (response.hasException) {
        print(response.exception);
      } else {
        yield LoadedAddonsState(
            addonsModel: addonsModel, count: addonsModel.length);
      }
    } catch (error) {
      print(error);
    }
  }
}
