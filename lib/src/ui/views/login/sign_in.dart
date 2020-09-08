import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pamiksa/src/blocs/Location/location_bloc.dart';
import 'package:pamiksa/src/data/graphql/graphql_config.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
import 'package:pamiksa/src/ui/views/home/home.dart';
import 'package:pamiksa/src/ui/views/login/sign_in_form.dart';
import 'package:pamiksa/src/ui/views/register/register_email.dart';
import 'package:pamiksa/src/ui/widget/waveclipper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:pamiksa/src/ui/navigation/route_paths.dart' as routes;

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final NavigationService navigationService = locator<NavigationService>();
  String msg = '';
  bool valid = true;
  SharedPreferences _prefs;
  String token;

  @override
  initState() {
    super.initState();
    SharedPreferences.getInstance()
      ..then((prefs) {
        setState(() {
          this._prefs = prefs;
          loadToken();
          if (token != null) {
            Navigator.pushReplacementNamed(context, routes.HomeRoute);
          }
        });
      });
  }

  loadToken() async {
    setState(() {
      this.token = _prefs.getString('token') ?? null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Theme.of(context).primaryColor,
            brightness: Brightness.dark,
          )),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Image.asset(
                "assets/images/pamiksa_logo_violeta_sin_fondo.png",
                width: 80,
                height: 80,
              ),
              // SizedBox(
              //   height: 10,
              // ),
              Text("Pamiksa",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      letterSpacing: 1.0)),
              SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: FormLogin(),
              ),
              Center(
                child: Text(
                  '¿ Has olvidado tu contraseña ?',
                  style: TextStyle(
                      color: Color(0xff6200EA),
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 7.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '¿ No tiene un usuario ? ',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    child: Text(
                      "Crear cuenta",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      navigationService.navigateTo(routes.RegisterEmailRoute);
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
