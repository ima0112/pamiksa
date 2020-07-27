import 'package:flutter/material.dart';
import 'package:pamiksa/facebook_login.dart';
import 'package:pamiksa/consts.dart' show PRIMARY_COLOR, INTRO_SMS, APP_NAME;
import 'package:path/path.dart';

class Intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
          color: PRIMARY_COLOR,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          animationDuration: Duration(milliseconds: 1000),
          onPressed: () {
            Navigator.of(context).pushReplacement(_createRouter());
//            Navigator.pushReplacement(context,
//                MaterialPageRoute(builder: (context) => Facebook_Login()));
          },
          child: Text(
            'COMENZAR',
            style: TextStyle(fontFamily: 'RobotoMono-Regular'),
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
        var begin = Offset(0.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
        return child;
      });
}
