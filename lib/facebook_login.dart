import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pamiksa/consts.dart'
    show FACEBOOK_COLOR, FACEBOOK_LOGIN_SMS, APP_NAME, FACEBOOK_SMS;

class Facebook_Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Stack(
            children: <Widget>[
              Facebook_Login_Photo(),
              Facebook_Login_Text(),
              Facebook_Login_Button(),
              Facebook_Login_TextSMS(),
            ],
          ),
        ),
      ),
    );
  }
}

class Facebook_Login_Photo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(-0.1, -0.70),
      child: Container(
        height: 190,
        width: 190,
        child: Image.asset('assets/images/clip.png'),
      ),
    );
  }
}

class Facebook_Login_Text extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 190,
        width: 300,
        child: Text(
          FACEBOOK_SMS,
          style: TextStyle(fontFamily: 'Roboto', fontSize: 30),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class Facebook_Login_Button extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, 0.77),
      child: Container(
        height: 45,
        width: 320,
        child: RaisedButton.icon(
          textColor: Colors.white,
          color: Colors.blueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          animationDuration: Duration(milliseconds: 1000),
          onPressed: () {

          },
          icon: Icon(Icons.add, size: 18),
          label: Text("CONTINUAR CON FACEBOOK"),
        ),
      ),
    );
  }
}

class Facebook_Login_TextSMS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, 1.35),
      child: Container(
        height: 190,
        width: 300,
        child: Text(
          FACEBOOK_LOGIN_SMS,
          style: TextStyle(fontFamily: 'Roboto-Regular', color: Colors.black54),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
