import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/app.dart';
import 'package:pamiksa/src/blocs/home/home_bloc.dart';
import 'package:pamiksa/src/data/graphql/graphql_config.dart';
import 'package:pamiksa/src/data/repositories/remote/business_repository.dart';
import 'package:pamiksa/src/ui/themes/theme_manager.dart';

void main() => runApp(MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ThemeCubit(),
        ),
        BlocProvider(
            create: (_) => HomeBloc(
                BusinessRepository(client: GraphQLConfiguration().clients())))
      ],
      child: MyApp(),
    ));

//void main() => runApp(MyApp());
