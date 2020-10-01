import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/app.dart';
import 'package:pamiksa/src/blocs/devices/devices_bloc.dart';
import 'package:pamiksa/src/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:pamiksa/src/blocs/forgot_password_email/forgot_password_email_bloc.dart';
import 'package:pamiksa/src/blocs/forgot_password_verification/forgot_password_verification_bloc.dart';
import 'package:pamiksa/src/blocs/home/home_bloc.dart';
import 'package:pamiksa/src/blocs/intro/intro_bloc.dart';
import 'package:pamiksa/src/blocs/register_location/register_location_bloc.dart';
import 'package:pamiksa/src/blocs/register_complete/register_complete_bloc.dart';
import 'package:pamiksa/src/blocs/register_email/register_email_bloc.dart';
import 'package:pamiksa/src/blocs/register_password/register_password_bloc.dart';
import 'package:pamiksa/src/blocs/register_personal_info/register_personal_info_bloc.dart';
import 'package:pamiksa/src/blocs/register_verification/register_verification_bloc.dart';
import 'package:pamiksa/src/blocs/sign_in/sign_in_bloc.dart';
import 'package:pamiksa/src/blocs/splash_screen/splash_screen_bloc.dart';
import 'package:pamiksa/src/blocs/Timer/ticker.dart';
import 'package:pamiksa/src/blocs/theme/theme_bloc.dart';
import 'package:pamiksa/src/data/graphql/graphql_config.dart';
import 'package:pamiksa/src/data/repositories/remote/business_repository.dart';
import 'package:pamiksa/src/data/repositories/remote/municipality_repository.dart';
import 'package:pamiksa/src/data/repositories/remote/province_repository.dart';
import 'package:pamiksa/src/data/repositories/remote/register_data_repository.dart';
import 'package:pamiksa/src/data/repositories/remote/sessions_repository.dart';
import 'package:pamiksa/src/data/repositories/remote/user_repository.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/data/models/user.dart';
import 'package:pamiksa/src/ui/navigation/route_paths.dart' as routes;

import 'src/blocs/Timer/timer_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String initialRoute = routes.LoginRoute;
  bool isUserLoggedIn = await UserModel().isLoggedIn();

  if (isUserLoggedIn) {
    initialRoute = routes.HomeRoute;
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
      BlocProvider(create: (context) => SplashScreenBloc()),
      BlocProvider(create: (context) => IntroBloc()),
      BlocProvider(
          create: (context) => RegisterPersonalInfoBloc(RegisterDataRepository(
              client: GraphQLConfiguration().clients()))),
      BlocProvider(
          create: (context) => LocationBloc(
              ProvinceRepository(client: GraphQLConfiguration().clients()),
              UserRepository(client: GraphQLConfiguration().clients()),
              MunicipalityRepository(
                  client: GraphQLConfiguration().clients()))),
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
        create: (context) => HomeBloc(
            BusinessRepository(client: GraphQLConfiguration().clients()),
            UserRepository(client: GraphQLConfiguration().clients())),
      ),
      BlocProvider(
        create: (context) => SignInBloc(
            UserRepository(client: GraphQLConfiguration().clients()),
            RegisterDataRepository(client: GraphQLConfiguration().clients()),
            ProvinceRepository(client: GraphQLConfiguration().clients()),
            MunicipalityRepository(client: GraphQLConfiguration().clients())),
      )
    ],
    child: MyApp(initialRoute: initialRoute),
  ));
}
