import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/app.dart';
import 'package:pamiksa/src/blocs/location/location_bloc.dart';
import 'package:pamiksa/src/blocs/register_complete/register_complete_bloc.dart';
import 'package:pamiksa/src/blocs/register_email/register_email_bloc.dart';
import 'package:pamiksa/src/blocs/register_password/register_password_bloc.dart';
import 'package:pamiksa/src/blocs/register_verification/register_verification_bloc.dart';
import 'package:pamiksa/src/blocs/timer/ticker.dart';
import 'package:pamiksa/src/blocs/timer/timer_bloc.dart';
import 'package:pamiksa/src/data/graphql/graphql_config.dart';
import 'package:pamiksa/src/data/repositories/remote/device_repository.dart';
import 'package:pamiksa/src/data/repositories/remote/provinces_repository.dart';
import 'package:pamiksa/src/data/repositories/remote/user_repository.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/themes/theme_manager.dart';

void main() {
  setupLocator();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => ThemeCubit(),
      ),
      BlocProvider(create: (context) => TimerBloc(ticker: Ticker())),
      BlocProvider(
          create: (context) => LocationBloc(
              ProvincesRepository(client: GraphQLConfiguration().clients()),
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
              DeviceRepository(client: GraphQLConfiguration().clients()))),
      BlocProvider(
        create: (context) => RegisterPasswordBloc(),
      ),
    ],
    child: MyApp(),
  ));
}
