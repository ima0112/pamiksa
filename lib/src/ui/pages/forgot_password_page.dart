import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
import 'package:pamiksa/src/ui/pages/pages.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new ForgotpasswordPageState();
}

class ForgotpasswordPageState extends State<ForgotPasswordPage> {
  final NavigationService navigationService = locator<NavigationService>();
  final _formKey = GlobalKey<FormState>();
  final _passKey = GlobalKey<FormFieldState<String>>();

  ForgotPasswordBloc forgotPasswordBloc;

  String password;
  String passwordtwo;
  bool _obscureText = true;

  _validatePassword(String value) {
    if (value.isEmpty) {
      return '¡Ingrese una contraseña!';
    }
    if (value.length < 8) {
      return '¡Debe poseer al menos 8 caracteres!';
    }
    return null;
  }

  _validatePasswordTwo(String value) {
    final pass = _passKey.currentState;
    if (value.isEmpty) {
      return '¡Ingrese una contraseña!';
    }
    if (value.length < 8) {
      return '¡Debe poseer al menos 8 caracteres!';
    }
    if (pass.value != value) {
      return '¡Las contraseñas no coinciden!';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    forgotPasswordBloc = BlocProvider.of<ForgotPasswordBloc>(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
        builder: (context, state) {
          if (state is ForgotPasswordInitial) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 5.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Restablecer contraseña",
                        style: TextStyle(fontFamily: 'Roboto', fontSize: 30),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 16.0),
                        child: Form(
                          key: _formKey,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  0.0, 25.0, 0.0, 0.0),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  TextFormField(
                                    initialValue: password,
                                    key: _passKey,
                                    obscureText: _obscureText,
                                    maxLength: 20,
                                    validator: (value) =>
                                        _validatePassword(value),
                                    onChanged: (String value) {
                                      password = value;
                                    },
                                    decoration: new InputDecoration(
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
                                  ),
                                  TextFormField(
                                    initialValue: passwordtwo,
                                    obscureText: _obscureText,
                                    maxLength: 20,
                                    validator: (value) =>
                                        _validatePasswordTwo(value),
                                    decoration: new InputDecoration(
                                      border: const UnderlineInputBorder(),
                                      filled: false,
                                      labelText: 'Verificar contraseña',
                                      icon: Icon(Icons.lock),
                                    ),
                                    onChanged: (String value) {
                                      passwordtwo = value;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                    Container(
                      margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                      padding: EdgeInsets.only(
                          top: 0.0, bottom: 0.0, right: 16.0, left: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            onPressed: () {
                              navigationService.goBack();
                            },
                            child: Text(
                              "ATRÁS",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          RaisedButton(
                            textColor: Colors.white,
                            color: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                forgotPasswordBloc
                                    .add(SaveUserNewPasswordEvent(password));
                              }
                            },
                            child: Text(
                              'SIGUIENTE',
                              style:
                                  TextStyle(fontFamily: 'RobotoMono-Regular'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is ErrorForgotPasswordState) {
            return ErrorPage(
              bloc: forgotPasswordBloc,
              event: state.event,
            );
          }
          return ErrorPage(
            bloc: forgotPasswordBloc,
            event: SetInitialForgotPasswordEvent(),
          );
        },
      ),
    );
  }
}
