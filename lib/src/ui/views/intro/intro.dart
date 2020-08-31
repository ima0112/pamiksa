import 'package:flutter/material.dart';
import 'package:pamiksa/src/data/route.dart';
import 'package:pamiksa/src/data/shared/shared.dart';
import 'package:pamiksa/src/ui/views/login/login.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  Ruta ruta = Ruta();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: AppBar(
              elevation: 0.0,
              backgroundColor: Color(0xffF5F5F5),
              brightness: Brightness.light,
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
                      saveShowIntro();
                      Navigator.of(context)
                          .pushReplacement(ruta.createRouter(LoginPage()));
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
    return Container(
      height: 190,
      width: 190,
      child: Image.asset('assets/images/deliverypurple.png'),
    );
  }

  Widget introText() {
    return Container(
      child: Text(
        "Tú comida favorita a domicilio",
        style: TextStyle(fontFamily: 'Roboto', fontSize: 30),
        textAlign: TextAlign.center,
      ),
    );
  }

  void saveShowIntro() async {
    Shared preferences = Shared();
    preferences.saveBool('showIntro', false);
  }
}
