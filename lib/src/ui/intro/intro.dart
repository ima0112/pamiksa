import 'package:flutter/material.dart';
import 'package:pamiksa/src/providers/themes/consts.dart'
    show COLORPRIMARYLIGTH, INTRO_SMS;
import 'package:pamiksa/src/ui/login/login.dart';

class Intro extends StatelessWidget {
  static const URI = '/intro';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Theme.of(context).primaryColor,
      ),
      home: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: AppBar(
              elevation: 0.0,
              backgroundColor: Color(0xffF5F5F5),
              brightness: Brightness.light,
            )),
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
          "Tú comida favorita a domicilio",
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
            Navigator.of(context).push(_createRouter());
          },
          child: Text(
            'COMENZAR',
            style: TextStyle(
                fontFamily: 'RobotoMono-Regular', fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }
}

Route _createRouter() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(50.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      });
}
