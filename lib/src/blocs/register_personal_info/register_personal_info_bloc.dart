import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/data/repositories/remote/register_data_repository.dart';
import 'package:pamiksa/src/data/storage/secure_storage.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';

part 'register_personal_info_event.dart';
part 'register_personal_info_state.dart';

class RegisterPersonalInfoBloc
    extends Bloc<RegisterPersonalInfoEvent, RegisterPersonalInfoState> {
  final NavigationService navigationService = locator<NavigationService>();
  final RegisterDataRepository registerDataRepository;

  SecureStorage secureStorage = SecureStorage();

  RegisterPersonalInfoBloc(this.registerDataRepository)
      : super(RegisterPersonalInfoInitial());

  @override
  Stream<RegisterPersonalInfoState> mapEventToState(
    RegisterPersonalInfoEvent event,
  ) async* {
    if (event is SaveUserPersonalInfoEvent) {
      yield* _mapSaveUserPersonalInfoEvent(event);
    }
    if (event is SelectDateEvent) {
      yield DateSelectedState();
    }
  }

  Stream<RegisterPersonalInfoState> _mapSaveUserPersonalInfoEvent(
      SaveUserPersonalInfoEvent event) async* {
    await secureStorage.save('fullname', event.fullname);
    await secureStorage.save('birthday', event.birthday);

    navigationService.navigateTo(Routes.RegisterLocationRoute);
  }
}
