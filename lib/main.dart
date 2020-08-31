import 'package:flutter/material.dart';
import 'package:pamiksa/src/app.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/Timer/bloc.dart';
import 'package:pamiksa/src/blocs/Timer/ticker.dart';
import 'package:pamiksa/src/ui/themes/theme_manager.dart';

void main() => runApp(MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(create: (context) => TimerBloc(ticker: Ticker()))
      ],
      child: MyApp(),
    ));
