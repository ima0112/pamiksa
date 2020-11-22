import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pamiksa/src/data/errors.dart';
import 'package:pamiksa/src/data/models/models.dart';
import 'package:pamiksa/src/data/repositories/remote/user_repository.dart';
import 'package:pamiksa/src/data/storage/secure_storage.dart';
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

  UserModel meModel;
  SecureStorage secureStorage = SecureStorage();
  File file;

  String name;
  String adress;
  String email;

  ProfileBloc(this.userRepository, this.minio) : super(ProfileInitial());

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
    } else if (event is ChangeNameEvent) {
      yield* _mapChangeNameEvent(event);
    } else if (event is ChangeEmailEvent) {
      yield* _mapChangeEmailEvent(event);
    } else if (event is ChangeAdressEvent) {
      yield* _mapChangeAdressEvent(event);
    } else if (event is ProfileRefreshTokenEvent) {
      yield* _mapProfileRefreshTokenEvent(event);
    } else if (event is SetProfileInitialStateEvent) {
      yield ProfileInitial();
    }
  }

  Stream<ProfileState> _mapCropProfileImageEvent(
      SetCropProfileEvent event) async* {
    yield CropProfileImageState();
  }

  Stream<ProfileState> _mapFetchProfileEvent(FetchProfileEvent event) async* {
    yield LoadingProfileState();
    try {
      final response = await userRepository.me();
      if (response.hasException) {
        if (response.exception.graphqlErrors[0].message ==
            Errors.TokenExpired) {
          yield ProfileTokenExpiredState();
        } else {
          yield ProfileConnectionFailedState();
        }
      } else {
        Map<dynamic, dynamic> meData = response.data['me'];
        userRepository.clear();
        meModel = UserModel(
            id: meData['id'],
            fullName: meData['fullName'],
            adress: meData['adress'],
            photo: meData['photo'],
            photoUrl: meData['photoUrl'],
            email: meData['email']);
        userRepository.insert(meModel.toMap());
        yield LoadedProfileState(meModel);
      }
    } catch (error) {
      yield ProfileConnectionFailedState();
    }
  }

  Stream<ProfileState> _mapSendImageEvent(SendImageEvent event) async* {
    file = event.file;
    try {
      await minio.fPutObject(DotEnv().env['USER_AVATAR_BULK_NAME'],
          '${basename(event.file.path)}', '${event.file.path}');
      final response =
          await userRepository.editProfile(basename(event.file.path));

      if (response.hasException) {
        if (response.hasException) {
          if (response.exception.graphqlErrors[0].message ==
              Errors.TokenExpired) {
            String refreshToken = await secureStorage.read(key: "refreshToken");

            final response = await userRepository.refreshToken(refreshToken);

            if (response.hasException) {
              yield ProfileConnectionFailedState();
            } else {
              add(SendImageEvent(file));
            }
          } else {
            yield ProfileConnectionFailedState();
          }
        }
      }
      final getUser = await userRepository.all();
      List<UserModel> retorno = List();
      retorno = getUser
          .map((e) => UserModel(
                id: e['id'].toString(),
                fullName: e['fullName'],
                adress: e['adress'],
                email: e['email'],
                photo: e['photo'],
                photoUrl: e['photoUrl'],
              ))
          .toList();
      if (retorno[0].photo != null) {
        await minio.removeObject(
            DotEnv().env['USER_AVATAR_BULK_NAME'], '${retorno[0].photo}');
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

  Stream<ProfileState> _mapChangeNameEvent(ChangeNameEvent event) async* {
    name = event.name;
    try {
      final response = await userRepository.editName(event.name);

      if (response.hasException) {
        if (response.hasException) {
          if (response.exception.graphqlErrors[0].message ==
              Errors.TokenExpired) {
            String refreshToken = await secureStorage.read(key: "refreshToken");

            final response = await userRepository.refreshToken(refreshToken);

            if (response.hasException) {
              yield ProfileConnectionFailedState();
            } else {
              add(ChangeNameEvent(name: name));
            }
          } else {
            yield ProfileConnectionFailedState();
          }
        }
      }

      navigationService.goBack();
      yield ProfileInitial();
    } catch (error) {
      print(error.toString());
    }
  }

  Stream<ProfileState> _mapChangeAdressEvent(ChangeAdressEvent event) async* {
    adress = event.adress;
    try {
      final response = await userRepository.editAdress(event.adress);

      if (response.hasException) {
        if (response.hasException) {
          if (response.exception.graphqlErrors[0].message ==
              Errors.TokenExpired) {
            String refreshToken = await secureStorage.read(key: "refreshToken");

            final response = await userRepository.refreshToken(refreshToken);

            if (response.hasException) {
              yield ProfileConnectionFailedState();
            } else {
              add(ChangeAdressEvent(adress: adress));
            }
          } else {
            yield ProfileConnectionFailedState();
          }
        }
      }

      navigationService.goBack();
      yield ProfileInitial();
    } catch (error) {
      print(error.toString());
    }
  }

  Stream<ProfileState> _mapChangeEmailEvent(ChangeEmailEvent event) async* {
    try {
      final response = await userRepository.editEmail(event.email);

      if (response.hasException) {
        if (response.hasException) {
          if (response.exception.graphqlErrors[0].message ==
              Errors.TokenExpired) {
            String refreshToken = await secureStorage.read(key: "refreshToken");

            final response = await userRepository.refreshToken(refreshToken);

            if (response.hasException) {
              yield ProfileConnectionFailedState();
            } else {
              add(ChangeEmailEvent(email: email));
            }
          } else {
            yield ProfileConnectionFailedState();
          }
        }
      }

      navigationService.goBack();
      yield ProfileInitial();
    } catch (error) {
      print(error.toString());
    }
  }

  Stream<ProfileState> _mapProfileRefreshTokenEvent(
      ProfileRefreshTokenEvent event) async* {
    try {
      String refreshToken = await secureStorage.read(key: "refreshToken");
      final response = await userRepository.refreshToken(refreshToken);
      if (response.hasException &&
          response.exception.graphqlErrors[0].message ==
              Errors.RefreshTokenExpired) {
        await navigationService.navigateWithoutGoBack(Routes.LoginRoute);
        yield ProfileInitial();
      } else if (response.hasException) {
        yield ProfileConnectionFailedState();
      } else {
        yield ProfileInitial();
      }
    } catch (error) {
      yield ProfileConnectionFailedState();
    }
  }
}
