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

class MyApp extends StatefulWidget {
  final String initialRoute;

  const MyApp({
    Key key,
    @required this.initialRoute,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeBloc themeBloc;
  ThemeMode themeMode;

  @override
  void initState() {
    themeBloc = BlocProvider.of<ThemeBloc>(context);
    themeBloc.add(LoadedThemeEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [GlobalMaterialLocalizations.delegate],
        supportedLocales: [const Locale('es')],
        title: APP_NAME,
        themeMode: state.themeData,
        theme: appThemeData[ThemeMode.light],
        darkTheme: appThemeData[ThemeMode.dark],
        onGenerateRoute: GenerateRoute.generateRoute,
        initialRoute: widget.initialRoute,
        navigatorKey: locator<NavigationService>().navigatorKey,
      );
    });
  }
}
