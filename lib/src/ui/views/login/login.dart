import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pamiksa/src/blocs/Location/location_bloc.dart';
import 'package:pamiksa/src/data/graphql/graphql_config.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
import 'package:pamiksa/src/ui/views/home/home.dart';
import 'package:pamiksa/src/ui/views/login/login_form.dart';
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
            Navigator.pushReplacementNamed(
                context, routes.HomeRoute);
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
    return GraphQLProvider(
        client: GraphQLConfiguration.client,
        child: CacheProvider(
            child: Scaffold(
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
                  Stack(
                    children: <Widget>[
                      ClipPath(
                        clipper: WaveClipper2(),
                        child: Container(
                          child: Column(),
                          width: double.infinity,
                          height: 300,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                            Color(0xff7C4DFF),
                            Color(0xff6200EA)
                          ])),
                        ),
                      ),
                      ClipPath(
                        clipper: WaveClipper3(),
                        child: Container(
                          child: Column(),
                          width: double.infinity,
                          height: 300,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                            Color(0xff6200EA),
                            Color(0xff5C4DFF)
                          ])),
                        ),
                      ),
                      ClipPath(
                        clipper: WaveClipper1(),
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 40,
                              ),
                              Icon(
                                Icons.fastfood,
                                color: Colors.white,
                                size: 60,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Pamiksa',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 30),
                              )
                            ],
                          ),
                          width: double.infinity,
                          height: 300,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                            Color(0xff6200EA),
                            Color(0xff7C4DFF)
                          ])),
                        ),
                      )
                    ],
                  ),
                  Expanded(flex: 1, child: FormLogin()),
                  Center(
                    child: Text(
                      '¿ Has olvidado tu contraseña ?',
                      style: TextStyle(
                          color: Color(0xff6200EA),
                          decoration: TextDecoration.underline,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 15,
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
                              decoration: TextDecoration.underline,
                              color: Theme.of(context).primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          navigationService
                              .navigateTo(routes.RegisterEmailRoute);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        )));
  }
}
