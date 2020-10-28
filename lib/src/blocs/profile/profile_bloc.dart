import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
            photoName: meData['photo'],
            photo: 'http://${DotEnv().env['MINIO_ADRESS']}:${DotEnv().env['MINIO_PORT']}/${DotEnv().env['USER_AVATAR_BULK_NAME']}/${meData['photo']}',
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
          DotEnv().env['USER_AVATAR_BULK_NAME'], '${basename(event.file.path)}', '${event.file.path}');
      final response = await userRepository.editProfile(basename(event.file.path));
      final getUser = await userRepository.all();
      List<UserModel> retorno = List();
      retorno = getUser
          .map((e) => UserModel(
                id: e['id'].toString(),
                fullName: e['fullName'],
                adress: e['adress'],
                email: e['email'],
                photo: e['photo'],
                photoName: e['photoName'],
              ))
          .toList();
      if (retorno[0].photo != null) {
        await minio.removeObject(DotEnv().env['USER_AVATAR_BULK_NAME'], '${retorno[0].photoName}');
      }
      if (response.hasException) {
        print("ERROR");
      } else {
        navigationService.goBack();
        yield ProfileInitial();
      }
    } catch (error) {
      print('$error');
    }
  }
}
