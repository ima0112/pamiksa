import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:minio/minio.dart';
import 'package:pamiksa/src/app.dart';
import 'package:pamiksa/src/blocs/blocs.dart';
import 'package:pamiksa/src/blocs/change_password/change_password_bloc.dart';
import 'package:pamiksa/src/blocs/favorite_details/favorite_details_bloc.dart';
import 'package:pamiksa/src/blocs/network_exception_splash_screen/network_exception_splash_screen_bloc.dart';
import 'package:pamiksa/src/blocs/profile/profile_bloc.dart';
import 'package:pamiksa/src/blocs/search_details/search_details_bloc.dart';
import 'package:pamiksa/src/data/graphql/graphql_config.dart';
import 'package:pamiksa/src/data/repositories/remote/food_repository.dart';
import 'package:pamiksa/src/data/repositories/repositories.dart';
import 'package:pamiksa/src/data/models/user.dart';
import 'package:pamiksa/src/data/utils.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';

void main() async {
  await DotEnv().load('.env');
  WidgetsFlutterBinding.ensureInitialized();

  String initialRoute = Routes.HomeRoute;

  bool isUserLoggedIn = await UserModel().isLoggedIn();
  bool showIntro = await Utils().showIntro();

  if (showIntro) {
    initialRoute = Routes.IntroRoute;
  } else if (isUserLoggedIn) {
    initialRoute = await Utils()
        .checkSession(UserRepository(client: GraphQLConfiguration().clients()));
  } else if (!isUserLoggedIn) {
    initialRoute = Routes.LoginRoute;
  }

  setupLocator();

  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => ForgotPasswordBloc(
                UserRepository(client: GraphQLConfiguration().clients()))),
        BlocProvider(
            create: (context) => ForgotPasswordVerificationBloc(
                UserRepository(client: GraphQLConfiguration().clients()))),
        BlocProvider(
            create: (context) => ForgotPasswordEmailBloc(
                UserRepository(client: GraphQLConfiguration().clients()))),
        BlocProvider(create: (context) => ThemeBloc()),
        BlocProvider(create: (context) => TimerBloc(ticker: TickerPamiksa())),
        BlocProvider(create: (context) => IntroBloc()),
        BlocProvider(
            create: (context) => RegisterPersonalInfoBloc(
                RegisterDataRepository(
                    client: GraphQLConfiguration().clients()))),
        BlocProvider(
            create: (context) => ProfileBloc(
                UserRepository(client: GraphQLConfiguration().clients()),
                Minio(
                    endPoint: DotEnv().env['MINIO_ADRESS'],
                    accessKey: DotEnv().env['MINIO_ACCESS_KEY'],
                    port: int.parse(DotEnv().env['MINIO_PORT']),
                    useSSL: DotEnv().env['MINIO_USE_SSL'] == 'true',
                    secretKey: DotEnv().env['MINIO_SECRET_KEY']))),
        BlocProvider(
            create: (context) => LocationBloc(
                ProvinceRepository(client: GraphQLConfiguration().clients()),
                UserRepository(client: GraphQLConfiguration().clients()),
                MunicipalityRepository(
                    client: GraphQLConfiguration().clients()))),
        BlocProvider(
            create: (context) => NetworkExceptionSplashScreenBloc(
                UserRepository(client: GraphQLConfiguration().clients()))),
        BlocProvider(
            create: (context) => RegisterEmailBloc(
                UserRepository(client: GraphQLConfiguration().clients()))),
        BlocProvider(
            create: (context) => RegisterVerificationBloc(
                UserRepository(client: GraphQLConfiguration().clients()))),
        BlocProvider(
            create: (context) => RegisterCompleteBloc(
                  UserRepository(client: GraphQLConfiguration().clients()),
                )),
        BlocProvider(
          create: (context) => RegisterPasswordBloc(),
        ),
        BlocProvider(
          create: (context) => DevicesBloc(
              SessionsRepository(client: GraphQLConfiguration().clients()),
              UserRepository(client: GraphQLConfiguration().clients())),
        ),
        BlocProvider(
          create: (context) => RootBloc(
              BusinessRepository(client: GraphQLConfiguration().clients()),
              UserRepository(client: GraphQLConfiguration().clients()),
              FavoriteRepository(client: GraphQLConfiguration().clients())),
        ),
        BlocProvider(
          create: (context) => SignInBloc(
              UserRepository(client: GraphQLConfiguration().clients()),
              RegisterDataRepository(client: GraphQLConfiguration().clients()),
              ProvinceRepository(client: GraphQLConfiguration().clients()),
              MunicipalityRepository(client: GraphQLConfiguration().clients())),
        ),
        BlocProvider(
          create: (context) => BusinessDetailsBloc(
              BusinessRepository(client: GraphQLConfiguration().clients()),
              FoodRepository(client: GraphQLConfiguration().clients()),
              UserRepository(client: GraphQLConfiguration().clients())),
        ),
        BlocProvider(
            create: (context) => SearchBloc(
                  SearchRepository(client: GraphQLConfiguration().clients()),
                  UserRepository(client: GraphQLConfiguration().clients()),
                  SuggestionRepository(
                      client: GraphQLConfiguration().clients()),
                )),
        BlocProvider(
            create: (context) => FavoriteBloc(
                FavoriteRepository(client: GraphQLConfiguration().clients()),
                UserRepository(client: GraphQLConfiguration().clients()))),
        BlocProvider(
            create: (context) => ChangePasswordBloc(
                UserRepository(client: GraphQLConfiguration().clients()))),
        BlocProvider(
            create: (context) => FoodBloc(
                  AddonsRepository(client: GraphQLConfiguration().clients()),
                  FoodRepository(client: GraphQLConfiguration().clients()),
                  UserRepository(client: GraphQLConfiguration().clients()),
                  FavoriteRepository(client: GraphQLConfiguration().clients()),
                )),
        BlocProvider(
            create: (context) => FavoriteDetailsBloc(
                UserRepository(client: GraphQLConfiguration().clients()),
                FavoriteRepository(client: GraphQLConfiguration().clients()),
                AddonsRepository(client: GraphQLConfiguration().clients()))),
        BlocProvider(
          create: (context) => SearchDetailsBloc(
              AddonsRepository(client: GraphQLConfiguration().clients()),
              UserRepository(client: GraphQLConfiguration().clients()),
              SearchRepository(client: GraphQLConfiguration().clients())),
        ),
      ],
      child: MyApp(
        initialRoute: initialRoute,
      )));
}
