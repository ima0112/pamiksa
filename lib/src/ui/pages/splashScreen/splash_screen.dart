import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/splash_screen/splash_screen_bloc.dart';
import 'package:pamiksa/src/blocs/theme/theme_bloc.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreenPage> {
  SplashScreenBloc splashScreenBloc;
  ThemeBloc themeBloc;

  void initState() {
    super.initState();
    themeBloc = BlocProvider.of<ThemeBloc>(context);
    splashScreenBloc = BlocProvider.of<SplashScreenBloc>(context);
    themeBloc.add(LoadedThemeEvent());
    splashScreenBloc.add(NavigationFromSplashScreenEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Image.asset("assets/images/ic_launcher.png"),
        ),
      ),
    );
  }
}
