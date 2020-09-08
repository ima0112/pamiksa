import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/data/repositories/remote/user_repository.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
import 'package:pamiksa/src/ui/navigation/route_paths.dart' as routes;

part 'sign_in_event.dart';

part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository userRepository;
  final NavigationService navigationService = locator<NavigationService>();

  SignInBloc(this.userRepository) : super(SignInInitial());

  @override
  Stream<SignInState> mapEventToState(
    SignInEvent event,
  ) async* {
    if (event is MutateSignInEvent) {
      yield* _mapMutateSignInEvent(event);
    }
  }

  Stream<SignInState> _mapMutateSignInEvent(MutateSignInEvent event) async* {
    yield WaitingSignInResponseState();
    try {
      final response =
          await this.userRepository.signIn(event.email, event.password);
      if (response.hasException) {
        yield CredentialsErrorState();
      } else {
        navigationService.navigateWithoutGoBack(routes.HomeRoute);
      }
    } catch (error) {
      yield CredentialsErrorState();
    }
  }
}
