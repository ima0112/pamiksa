import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pamiksa/src/data/graphql/mutations/user.dart';
import 'package:pamiksa/src/data/utils.dart';
import 'package:pamiksa/src/data/models/user.dart';
import 'package:pamiksa/src/ui/views/home/home.dart';
import 'package:pamiksa/src/ui/views/register/register_email.dart';
import 'dart:async';
import 'package:pamiksa/src/ui/navigation/route_paths.dart' as routes;

import 'package:shared_preferences/shared_preferences.dart';

SharedPref prefs = new SharedPref();

class FormLogin extends StatefulWidget {
  @override
  FormLoginState createState() => new FormLoginState();
}

class FormLoginState extends State<FormLogin> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  String token;

  _validateEmail(String value) {
    if (value.isEmpty) {
      return '¡Ingrese un correo electrónico!';
    }
    // Regex para validación de email
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);
    if (regExp.hasMatch(value)) {
      return null;
    }
    return '¡El correo electrónico no es válido!';
  }

  _validatePassword(String value) {
    if (value.isEmpty) {
      return '¡Ingrese una contraseña!';
    }
    if (value.length < 8) {
      return '¡Debe poseer al menos 8 caracteres!';
    }
    return null;
  }

  String _email;
  String _password;
  int _state = 0;
  Animation _animation;
  AnimationController _controller;
  GlobalKey _globalKey = GlobalKey();
  double _width = double.maxFinite;
  dynamic returnData;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 16.0),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(fontSize: 16),
                  decoration: const InputDecoration(
                    helperText: "",
                    border: UnderlineInputBorder(),
                    labelText: 'Correo electrónico',
                    filled: false,
                    icon: Icon(Icons.email),
                  ),
                  onChanged: (String value) {
                    setState(() {
                      _email = value;
                    });
                  },
                  validator: (value) => _validateEmail(value),
                ),
              ),
              Expanded(
                flex: 2,
                child: TextFormField(
                  obscureText: _obscureText,
                  maxLength: 20,
                  validator: (value) => _validatePassword(value),
                  decoration: new InputDecoration(
                    helperText: "",
                    border: const UnderlineInputBorder(),
                    filled: false,
                    labelText: 'Contraseña',
                    icon: Icon(Icons.lock),
                    suffixIcon: new GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: new Icon(_obscureText
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ),
                  onChanged: (String value) {
                    setState(() {
                      _password = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Mutation(
                options: MutationOptions(
                    documentNode: gql(singIn),
                    update: (Cache cache, QueryResult result) {
                      return cache;
                    },
                    onCompleted: (dynamic resultData) {
                      if (resultData != null) {
                        returnData = resultData;
                      } else {
                        print('No data from request');
                      }
                    }),
                builder: (RunMutation mutation, QueryResult result) {
                  return Expanded(
                    flex: 1,
                    child: Center(
                      child: Align(
                        alignment: Alignment.center,
                        child: PhysicalModel(
                          elevation: 2,
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(25),
                          child: Container(
                            key: _globalKey,
                            height: 45,
                            width: _width,
                            child: RaisedButton(
                              textColor: Colors.white,
                              color: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              padding: EdgeInsets.all(0),
                              child: setUpButtonChild(),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  mutation(
                                      {'email': _email, 'password': _password});
                                  setState(() {
                                    if (_state == 0) {
                                      animateButton(mutation);
                                    } else {
                                      _state = 0;
                                      _width = _width;
                                    }
                                  });
                                }
                              },
                              elevation: 0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }

  setUpButtonChild() {
    if (_state == 0) {
      return Text(
        "INICIAR SESIÓN",
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
      );
    } else if (_state == 1) {
      return SizedBox(
        height: 36,
        width: 36,
        child: CircularProgressIndicator(
          value: null,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }

  void animateButton(mutation) {
    double initialWidth = _globalKey.currentContext.size.width;

    _controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);

    _animation = Tween(begin: 0.0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {
          _width = initialWidth - ((initialWidth - 48) * _animation.value);
        });
      });
    _controller.forward();

    setState(() {
      _state = 1;
    });

    Timer(Duration(milliseconds: 1200), () {
      setState(() {
        if (returnData != null) {
          _state = 2;
          _saveToken(returnData['signIn']['token'],
              returnData['signIn']['refreshToken'], context);
        } else {
          _state = 0;
          _width = double.maxFinite;
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Usuario o Contraseña incorrectos'),
          ));
        }
      });
    });
  }
}

_saveToken(String token, String refreshToken, BuildContext context) async {
  SharedPref prefs = new SharedPref();
  prefs.save('token', token);
  prefs.save('refreshToken', refreshToken);
  // Navigator.pushReplacement(
  //     context, MaterialPageRoute(builder: (_) => Home()));
  Navigator.pushReplacementNamed(context, routes.HomeRoute);
}
