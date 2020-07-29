import 'package:flutter/material.dart';
import 'package:pamiksa/facebook_login.dart';
import 'package:pamiksa/consts.dart' show COLORPRIMARYLIGTH, INTRO_SMS;

class Intro extends StatelessWidget {
  static const URI = '/intro';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: COLORPRIMARYLIGTH
      ),
      home: Scaffold(
        body: Center(
          child: Stack(
            children: <Widget>[
              IntroPhoto(),
              IntroText(),
              IntroButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class IntroPhoto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(-0.1, -0.70),
      child: Container(
        height: 190,
        width: 190,
        child: Image.asset('assets/images/deliverypurple.png'),
      ),
    );
  }
}

class IntroText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 190,
        width: 300,
        child: Text(
          INTRO_SMS,
          style: TextStyle(fontFamily: 'Roboto', fontSize: 30),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class IntroButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, 0.77),
      child: Container(
        height: 45,
        width: 320,
        child: RaisedButton(
          textColor: Colors.white,
          color: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(_createRouter());
          },
          child: Text(
            'COMENZAR',
            style: TextStyle(fontFamily: 'RobotoMono-Regular', fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }
}

Route _createRouter() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Facebook_Login(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      });
}
