import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/data/storage/secure_storage.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
import 'package:pamiksa/src/data/repositories/remote/user_repository.dart';
import 'package:pamiksa/src/ui/navigation/route_paths.dart' as routes;

part 'register_email_event.dart';
part 'register_email_state.dart';

class RegisterEmailBloc extends Bloc<RegisterEmailEvent, RegisterEmailState> {
  final UserRepository userRepository;
  final NavigationService navigationService = locator<NavigationService>();
  SecureStorage secureStorage = SecureStorage();
  RegisterEmailBloc(this.userRepository) : super(RegisterEmailInitial());

  @override
  Stream<RegisterEmailState> mapEventToState(
    RegisterEmailEvent event,
  ) async* {
    if (event is CheckUserEmailEvent) {
      yield* _mapCheckUserEmailEvent(event);
    }
  }

  Stream<RegisterEmailState> _mapCheckUserEmailEvent(
      CheckUserEmailEvent event) async* {
    yield LoadingState();
    final response = await this.userRepository.userExists(event.email);

    if (response.data['userExists'] == true) {
      yield ExistsUserEmailState();
    } else if (response.data['userExists'] == false) {
      await secureStorage.save('email', event.email);
      print({await secureStorage.read('email')});
      await navigationService.navigateTo(routes.RegisterPasswordRoute);
      yield RegisterEmailInitial();
    }
  }
}
