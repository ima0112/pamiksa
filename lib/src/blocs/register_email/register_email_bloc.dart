import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/data/shared/shared.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
import 'package:pamiksa/src/data/repositories/remote/user_repository.dart';
import 'package:pamiksa/src/ui/navigation/route_paths.dart' as routes;

part 'register_email_event.dart';
part 'register_email_state.dart';

class RegisterEmailBloc extends Bloc<RegisterEmailEvent, RegisterEmailState> {
  final UserRepository userRepository;
  final NavigationService navigationService = locator<NavigationService>();
  Shared preferences = Shared();
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
      await preferences.saveString('email', event.email);
      print({await preferences.read('email')});
      await navigationService.navigateTo(routes.RegisterPasswordRoute);
      yield RegisterEmailInitial();
    }
  }
}
