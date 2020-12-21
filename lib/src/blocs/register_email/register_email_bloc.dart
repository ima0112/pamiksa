import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/data/storage/secure_storage.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
import 'package:pamiksa/src/data/repositories/remote/user_repository.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';

part 'register_email_event.dart';
part 'register_email_state.dart';

class RegisterEmailBloc extends Bloc<RegisterEmailEvent, RegisterEmailState> {
  final UserRepository userRepository;
  final NavigationService navigationService = locator<NavigationService>();

  SecureStorage secureStorage = SecureStorage();
  RegisterEmailBloc(this.userRepository) : super(RegisterEmailInitial());
  String email;

  @override
  Stream<RegisterEmailState> mapEventToState(
    RegisterEmailEvent event,
  ) async* {
    if (event is CheckUserEmailEvent) {
      yield* _mapCheckUserEmailEvent(event);
    } else if (event is SetInitialRegisterEmailEvent) {
      yield RegisterEmailInitial();
    }
  }

  Stream<RegisterEmailState> _mapCheckUserEmailEvent(
      CheckUserEmailEvent event) async* {
    yield RegisterEmailLoadingState();
    email = event.email;
    try {
      final response = await this.userRepository.userExists(event.email);

      if (response.data['userExists'] == true) {
        yield ExistsUserEmailState();
      } else if (response.data['userExists'] == false) {
        await secureStorage.save(key: 'email', value: event.email);
        print({await secureStorage.read(key: 'email')});

        navigationService.navigateTo(Routes.RegisterPasswordRoute);
      }
    } catch (error) {
      yield ErrorRegisterEmailState(event);
    }
  }
}
