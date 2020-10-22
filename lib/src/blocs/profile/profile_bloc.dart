import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/data/models/models.dart';
import 'package:pamiksa/src/data/repositories/remote/user_repository.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';
import 'package:minio/io.dart';
import 'package:minio/minio.dart';
import 'package:path/path.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository userRepository;
  final Minio minio;
  final NavigationService navigationService = locator<NavigationService>();

  ProfileBloc(this.userRepository, this.minio) : super(ProfileInitial());
  UserModel meModel;

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is FetchProfileEvent) {
      yield* _mapFetchProfileEvent(event);
    } else if (event is SendImageEvent) {
      yield* _mapSendImageEvent(event);
    } else if (event is SetCropProfileEvent) {
      yield* _mapCropProfileImageEvent(event);
    } else if (event is SetProfileInitialStateEvent) {
      yield ProfileInitial();
    }
  }

  Stream<ProfileState> _mapCropProfileImageEvent(
      SetCropProfileEvent event) async* {
    yield CropProfileImageState();
  }

  Stream<ProfileState> _mapFetchProfileEvent(FetchProfileEvent event) async* {
    try {
      final response = await userRepository.me();
      if (response.hasException) {
        yield ProfileConnectionFailedState();
      } else {
        Map<dynamic, dynamic> meData = response.data['me'];
        userRepository.clear();
        meModel = UserModel(
            id: meData['id'],
            fullName: meData['fullName'],
            adress: meData['adress'],
            photo: meData['photo'],
            email: meData['email']);
        userRepository.insert(meModel.toMap());
        yield LoadedProfileState(meModel);
      }
    } catch (error) {
      yield ProfileConnectionFailedState();
    }
  }

  Stream<ProfileState> _mapSendImageEvent(SendImageEvent event) async* {
    try {
      await minio.fPutObject(
          'user-avatar', '${basename(event.file.path)}', '${event.file.path}');
      final response =
          await userRepository.editProfile(basename(event.file.path));
      final getUser = await userRepository.all();
      List<UserModel> retorno = List();
      retorno = getUser
          .map((e) => UserModel(
                id: e['id'].toString(),
                fullName: e['fullName'],
                adress: e['adress'],
                email: e['email'],
                photo: e['photo'],
              ))
          .toList();
      if (retorno[0].photo != null) {
        await minio.removeObject('user-avatar', '${retorno[0].photo}');
      }
      if (response.hasException) {
        print("ERROR");
      } else {
        navigationService.navigateWithoutGoBack("/profile");
        yield ProfileInitial();
      }
    } catch (error) {
      print('$error');
    }
  }
}
