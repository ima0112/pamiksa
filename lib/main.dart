import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/app.dart';
import 'package:pamiksa/src/blocs/blocs.dart';
import 'package:pamiksa/src/data/graphql/graphql_config.dart';
import 'package:pamiksa/src/data/repositories/repositories.dart';
import 'package:pamiksa/src/data/models/user.dart';
import 'package:pamiksa/src/data/utils.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String initialRoute = Routes.LoginRoute;
  bool showIntro = await Utils().showIntro();
  bool isUserLoggedIn = await UserModel().isLoggedIn();

  if (showIntro) {
    initialRoute = Routes.IntroRoute;
  } else if (isUserLoggedIn) {
    initialRoute = Routes.HomeRoute;
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
