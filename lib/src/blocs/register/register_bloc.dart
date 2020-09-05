import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
import 'package:pamiksa/src/data/repositories/remote/user_repository.dart';
import 'package:pamiksa/src/ui/navigation/route_paths.dart' as routes;

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;
  final NavigationService navigationService = locator<NavigationService>();
  RegisterBloc(this.userRepository) : super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is CheckUserEmailEvent) {
      yield* _mapCheckUserEmailEvent(event);
    }
  }

  Stream<RegisterState> _mapCheckUserEmailEvent(
      CheckUserEmailEvent event) async* {
    final response = await this.userRepository.userEmailExists(event.email);

    if (response.data['userExists'] == true) {
      yield ExistsUserEmailState();
    } else if (response.data['userExists'] == false) {
      navigationService.navigateTo(routes.RegisterPasswordRoute);
    }
  }
}
