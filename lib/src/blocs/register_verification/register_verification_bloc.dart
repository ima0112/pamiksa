import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pamiksa/src/data/graphql/mutations/mutations.dart';
import 'package:pamiksa/src/data/models/user.dart';
import 'package:pamiksa/src/data/repositories/remote/user_repository.dart';
import 'package:pamiksa/src/data/shared/shared.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
import 'package:pamiksa/src/ui/navigation/route_paths.dart' as routes;

part 'register_verification_event.dart';
part 'register_verification_state.dart';

class RegisterVerificationBloc
    extends Bloc<RegisterVerificationEvent, RegisterVerificationState> {
  final UserRepository userRepository;
  final NavigationService navigationService = locator<NavigationService>();
  RegisterVerificationBloc(this.userRepository)
      : super(RegisterVerificationInitial());

  @override
  Stream<RegisterVerificationState> mapEventToState(
    RegisterVerificationEvent event,
  ) async* {
    if (event is MutateUserEvent) {
      yield* _mapMutateUserEvent(event);
    }
  }

  Stream<RegisterVerificationState> _mapMutateUserEvent(
      MutateUserEvent event) async* {
    final response = await this.userRepository.signUp(event.userModel);

    print(response.data.toString());
    navigationService.navigateTo(routes.RegisterCompleteRoute);
  }
}
