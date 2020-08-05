import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:pamiksa/src/ui/register/register_location/register_location_form.dart';

class RegisterLocationPage extends StatelessWidget {
  static const URI = '/registerlocation';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return RegisterLocation();
  }
}
class RegisterLocation extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new RegisterLocationState();
}

class RegisterLocationState extends State<RegisterLocation> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Color(0xffF5F5F5),
            brightness: Brightness.light,
          )),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Container(
              child: Text(
                "Crear cuenta",
                style: TextStyle(fontFamily: 'Roboto', fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              height: 500,
              margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 16.0),
              padding: EdgeInsets.only(
                  top: 0.0, bottom: 0.0, right: 16.0, left: 16.0),
              child: Form(
                key: _formKey,
                child: RegisterLocationForm(),
              ),
            ),
            SizedBox(
              height: 45,
            ),
            Divider(),
            SizedBox(height: 6,),
            Container(
              height: 40,
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              padding: EdgeInsets.only(
                  top: 0.0, bottom: 0.0, right: 16.0, left: 16.0),
              child: Row(
                children: <Widget>[
                  FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "ATRÁS",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  SizedBox(
                    width: 130,
                  ),
                  RaisedButton(
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
//                          Navigator.of(context).push(_createRouter());
                      }
                    },
                    child: Text(
                      'SIGUIENTE',
                      style: TextStyle(fontFamily: 'RobotoMono-Regular'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Route _createRouter() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          RegisterLocation(),
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
