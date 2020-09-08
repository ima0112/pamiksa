import 'package:flutter/material.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pamiksa/src/ui/navigation/route_paths.dart' as routes;

class SplashScreenPage extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreenPage> {
  final NavigationService navigationService = locator<NavigationService>();
  SharedPreferences _preferences;
  bool _showIntro;

  void initState() {
    super.initState();
    SharedPreferences.getInstance()
      ..then((prefs) {
        setState(() {
          this._preferences = prefs;
          loadShowIntro();
          if (_showIntro == null) {
            //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
            Navigator.pushReplacementNamed(context, routes.IntroRoute);
          } else if (_showIntro == false) {
            Navigator.pushReplacementNamed(context, routes.LoginRoute);
          }
        });
      });
  }

  loadShowIntro() async {
    this._showIntro = _preferences.getBool('showIntro') ?? null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.lightBlueAccent, Colors.white])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              padding: EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 70.0, bottom: 20.0),
              child: new Text(
                "Hello World",
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            new Container(
              padding: EdgeInsets.all(10.0),
              child: new Icon(
                Icons.bubble_chart,
                color: Colors.white,
                size: 130.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
