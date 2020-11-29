import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/blocs.dart';
import 'package:pamiksa/src/blocs/intro/intro_bloc.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<IntroPage> {
  ThemeBloc themeBloc;
  IntroBloc introBloc;

  @override
  void initState() {
    // themeBloc = BlocProvider.of<ThemeBloc>(context);
    // themeBloc.add(LoadedThemeEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    introBloc = BlocProvider.of<IntroBloc>(context);
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: AppBar(
              elevation: 0.0,
              backgroundColor: Theme.of(context).primaryColorLight,
              brightness: Theme.of(context).brightness,
            )),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 50.0),
            child: Column(
              children: <Widget>[
                introPhoto(),
                introText(),
                Spacer(flex: 1),
                Container(
                  height: 45,
                  width: 320,
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    onPressed: () {
                      introBloc.add(NotShowIntroEvent());
                    },
                    child: Text(
                      'COMENZAR',
                      style: TextStyle(
                          fontFamily: 'RobotoMono-Regular',
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget introPhoto() {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: EdgeInsets.only(top: 25.0),
        child: Image.asset(
          'assets/images/enjoy_the_moment.jpg',
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget introText() {
    return Container(
      child: Text(
        "Disfruta el momento",
        style: TextStyle(fontFamily: 'Roboto', fontSize: 30),
        textAlign: TextAlign.center,
      ),
    );
  }
}
