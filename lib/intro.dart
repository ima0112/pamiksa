import 'package:flutter/material.dart';
import 'package:pamiksa/consts.dart' show COLOR, INTRO_SMS;

class Intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          IntroPhoto(),
          IntroText(),
          IntroButton(),
        ],
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

class IntroButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, 0.86),
      child: Container(
        height: 45,
        width: 320,
        child: RaisedButton(
          textColor: Colors.white,
          color: COLOR,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          animationDuration: Duration(milliseconds: 1000),
          onPressed: () {
            // Respond to button press
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
