import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pamiksa/src/blocs/blocs.dart';
import 'package:pamiksa/src/data/graphql/graphql_config.dart';
import 'package:pamiksa/src/data/repositories/remote/remote_repository.dart';
import 'package:pamiksa/src/data/utils.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';
import 'package:pamiksa/src/ui/themes/theme_manager.dart';
import 'package:pamiksa/src/ui/themes/consts.dart' show APP_NAME;

class MyApp extends StatelessWidget {
  final String initialRoute;
  final ThemeMode themeMode;

  const MyApp({
    Key key,
    @required this.initialRoute,
    this.themeMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeMode theme;
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
      if (theme == null) {
        if (themeMode != state.themeData) {
          theme = state.themeData;
        } else {
          theme = themeMode;
        }
      } else {
        theme = state.themeData;
        if (themeMode != theme) {}
      }

      return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [GlobalMaterialLocalizations.delegate],
        supportedLocales: [const Locale('es')],
        title: APP_NAME,
        themeMode: theme,
        theme: appThemeData[ThemeMode.light],
        darkTheme: appThemeData[ThemeMode.dark],
        onGenerateRoute: GenerateRoute.generateRoute,
        initialRoute: initialRoute,
        navigatorKey: locator<NavigationService>().navigatorKey,
      );
    });
  }
}
