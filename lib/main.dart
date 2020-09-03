import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pamiksa/src/app.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/Location/location_bloc.dart';
import 'package:pamiksa/src/blocs/Timer/bloc.dart';
import 'package:pamiksa/src/blocs/Timer/ticker.dart';
import 'package:pamiksa/src/data/graphql/graphql_config.dart';
import 'package:pamiksa/src/data/repositories/repository.dart';
import 'package:pamiksa/src/ui/themes/theme_manager.dart';

void main() => runApp(MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(create: (context) => TimerBloc(ticker: Ticker())),
        BlocProvider(
            create: (context) => LocationBloc(
                Repository(client: GraphQLConfiguration().clients())))
      ],
      child: MyApp(),
    ));
