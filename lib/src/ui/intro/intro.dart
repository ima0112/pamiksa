import 'package:flutter/material.dart';
import 'package:pamiksa/src/ui/login/login.dart';
import 'package:flutter/services.dart';

class Intro extends StatelessWidget {

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
            padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
            child: Column(
              children: <Widget>[
                IntroPhoto(),
                IntroText(),
                SizedBox(height: 80.0,),
                IntroButton()
              ],
            ),
          ),
        )
      );
  }
}

class IntroPhoto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      width: 190,
      child: Image.asset('assets/images/deliverypurple.png'),
    );
  }
}

class IntroText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      width: 300,
      child: Text(
        "Tú comida favorita a domicilio",
        style: TextStyle(fontFamily: 'Roboto', fontSize: 30),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class IntroButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
          style: TextStyle(
              fontFamily: 'RobotoMono-Regular', fontWeight: FontWeight.w900),
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
