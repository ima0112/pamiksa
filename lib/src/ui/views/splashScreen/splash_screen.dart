import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/splash_screen/splash_screen_bloc.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreenPage> {
  SplashScreenBloc splashScreenBloc;

  void initState() {
    super.initState();
    splashScreenBloc = BlocProvider.of<SplashScreenBloc>(context);
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
