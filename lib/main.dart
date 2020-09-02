import 'package:flutter/material.dart';
import 'package:pamiksa/src/app.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/home_bloc.dart';
import 'package:pamiksa/src/data/graphql/graphqlConfig.dart';
import 'package:pamiksa/src/data/repositories/BusinessRepository.dart';
import 'package:pamiksa/src/ui/themes/theme_manager.dart';

void main() => runApp(MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ThemeCubit(),
        ),
        BlocProvider(create: (context) => HomeBloc(BusinessRepository(client: GraphQLConfiguration().clients())))

],
      child: MyApp(),
    ));

//void main() => runApp(MyApp());
