import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/data/models/models.dart';
import 'package:pamiksa/src/data/repositories/remote/user_repository.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository userRepository;

  ProfileBloc(this.userRepository) : super(ProfileInitial());
  UserModel meModel;

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is FetchProfileEvent) {
      yield* _mapFetchProfileEvent(event);
    }
  }

  Stream<ProfileState> _mapFetchProfileEvent(FetchProfileEvent event) async* {
    try {
      final response = await userRepository.me();
      if (response.hasException) {
        yield ProfileConnectionFailedState();
      } else {
        Map<dynamic, dynamic> meData = response.data['me'];
        meModel = UserModel(
            id: meData['id'],
            fullName: meData['fullName'],
            adress: meData['adress'],
            photo: meData['photo'],
            email: meData['email']);
        yield LoadedProfileState(meModel);
      }
    } catch (error) {
      yield ProfileConnectionFailedState();
    }
  }
}
