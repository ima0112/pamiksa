import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pamiksa/src/app.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/Location/location_bloc.dart';
import 'package:pamiksa/src/blocs/Register/register_bloc.dart';
import 'package:pamiksa/src/blocs/Timer/timer_bloc.dart';
import 'package:pamiksa/src/blocs/Timer/ticker.dart';
import 'package:pamiksa/src/data/graphql/graphql_config.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/data/repositories/remote/provinces_repository.dart';
import 'package:pamiksa/src/data/repositories/remote/user_repository.dart';
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
              ProvincesRepository(client: GraphQLConfiguration().clients()))),
      BlocProvider(
          create: (context) => RegisterBloc(
              UserRepository(client: GraphQLConfiguration().clients()))),
    ],
    child: MyApp(),
  ));
}
