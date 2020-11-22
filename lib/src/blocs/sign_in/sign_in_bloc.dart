import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/data/models/device.dart';
import 'package:pamiksa/src/data/models/municipality.dart';
import 'package:pamiksa/src/data/models/province.dart';
import 'package:pamiksa/src/data/repositories/remote/municipality_repository.dart';
import 'package:pamiksa/src/data/repositories/remote/province_repository.dart';
import 'package:pamiksa/src/data/repositories/remote/register_data_repository.dart';
import 'package:pamiksa/src/data/repositories/remote/user_repository.dart';
import 'package:pamiksa/src/data/storage/secure_storage.dart';
import 'package:pamiksa/src/data/storage/shared.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
import 'package:pamiksa/src/data/device_info.dart' as deviceInfo;
import 'package:pamiksa/src/ui/navigation/navigation.dart';
import 'package:pamiksa/src/data/errors.dart';

part 'sign_in_event.dart';

part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final NavigationService navigationService = locator<NavigationService>();

  final UserRepository userRepository;
  final RegisterDataRepository registerDataRepository;
  final ProvinceRepository provincesRepository;
  final MunicipalityRepository municipalityRepository;

  DeviceModel deviceModel = DeviceModel();
  List<ProvinceModel> provinceModel = List();
  List<MunicipalityModel> municipalityModel = List();
  Shared preferences = Shared();
  SecureStorage secureStorage = SecureStorage();

  SignInBloc(this.userRepository, this.registerDataRepository,
      this.provincesRepository, this.municipalityRepository)
      : super(SignInInitial());

  @override
  Stream<SignInState> mapEventToState(
    SignInEvent event,
  ) async* {
    if (event is GetRegisterDataEvent) {
      yield* _mapGetRegisterDataEvent(event);
    } else if (event is MutateSignInEvent) {
      yield* _mapMutateSignInEvent(event);
    }
    yield SignInInitial();
  }

  Stream<SignInState> _mapMutateSignInEvent(MutateSignInEvent event) async* {
    yield WaitingSignInResponseState();
    try {
      await deviceInfo.initPlatformState(deviceModel);
      final response = await this
          .userRepository
          .signIn(event.email, event.password, deviceModel);
      preferences.saveInt('lightMode', 0);

      if (response.hasException) {
        print(response.exception);
        if (response.hasException) {
          if (response.exception.graphqlErrors[0].message ==
              Errors.TokenExpired) {
            String refreshToken = await secureStorage.read(key: "refreshToken");

            final response = await userRepository.refreshToken(refreshToken);

            if (response.hasException) {
              yield ConnectionFailedState();
            } else {
              add(MutateSignInEvent());
            }
          } else {
            yield ConnectionFailedState();
          }
        } else if (response.exception.graphqlErrors[0].message ==
            Errors.InvalidCredentials) {
          yield CredentialsErrorState();
        } else if (response.exception.graphqlErrors[0].message ==
            Errors.BannedUser) {
          navigationService.navigateWithoutGoBack(Routes.UserBannedRoute);
        } else if (response.exception.graphqlErrors[0].message ==
            Errors.BannedDevice) {
          navigationService.navigateWithoutGoBack(Routes.DeviceBannedRoute);
        }
      } else {
        navigationService.navigateWithoutGoBack(Routes.HomeRoute);
        yield SignInInitial();
      }
    } catch (error) {
      print({"Error": error});
      yield ConnectionFailedState();
    }
  }

  Stream<SignInState> _mapGetRegisterDataEvent(
      GetRegisterDataEvent event) async* {
    try {
      yield LoadingSignState();

      final response = await this.registerDataRepository.registerData();

      if (response.hasException) {
        if (response.hasException) {
          if (response.exception.graphqlErrors[0].message ==
              Errors.TokenExpired) {
            String refreshToken = await secureStorage.read(key: "refreshToken");

            final response = await userRepository.refreshToken(refreshToken);

            if (response.hasException) {
              yield ConnectionFailedState();
            } else {
              add(GetRegisterDataEvent());
            }
          } else {
            yield ConnectionFailedState();
          }
        }
      } else {
        final List provincesData = response.data['provinces'];
        provinceModel = provincesData
            .map((e) => ProvinceModel(
                  id: e['id'],
                  name: e['name'],
                ))
            .toList();
        provincesRepository.clear();
        provinceModel.forEach((element) {
          provincesRepository.insert(element.toMap());
        });

        final List municipalityData = response.data['municipalities'];
        municipalityModel = municipalityData
            .map((e) => MunicipalityModel(
                id: e['id'], name: e['name'], provinceFk: e['provinceFk']))
            .toList();
        municipalityRepository.clear();
        municipalityModel.forEach((element) {
          municipalityRepository.insert(element.toMap());
        });

        String date = response.data['dateNow'];
        int year = int.parse(date.substring(0, 4)) - 18;
        int month = int.parse(date.substring(5, 7));
        int day = int.parse(date.substring(8));

        preferences.saveInt('year', year);
        preferences.saveInt('month', month);
        preferences.saveInt('day', day);
      }
    } catch (error) {
      yield ConnectionFailedState();
    }
  }
}
