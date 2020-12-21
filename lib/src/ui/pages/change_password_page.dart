import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/blocs.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
import 'package:pamiksa/src/ui/pages/error_page.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final NavigationService navigationService = locator<NavigationService>();

  final _formKey = GlobalKey<FormState>();
  final _passKey = GlobalKey<FormFieldState<String>>();

  ChangePasswordBloc changePasswordBloc;

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
  void initState() {
    changePasswordBloc = BlocProvider.of<ChangePasswordBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cambiar contraseña",
          style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontWeight: FontWeight.bold),
        ),
        elevation: 2.0,
      ),
      body: BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
        builder: (context, state) {
          if (state is ChangingPasswordState) {
            return Align(
              alignment: Alignment.topCenter,
              child: LinearProgressIndicator(),
            );
          } else if (state is ErrorChangePasswordState) {
            return ErrorPage(event: state.event, bloc: changePasswordBloc);
          } else if (state is ChangePasswordInitial) {
            return Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: form(),
                  ),
                  Divider(
                    height: 0.0,
                  ),
                  downButtons(),
                ],
              ),
            );
          }
          return ErrorPage(
              event: SetInitialChangePasswordEvent(), bloc: changePasswordBloc);
        },
      ),
    );
  }

  Widget form() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 0.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.center,
                child: TextFormField(
                  initialValue: password,
                  key: _passKey,
                  obscureText: _obscureText,
                  maxLength: 20,
                  validator: (value) => _validatePassword(value),
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
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.topCenter,
                child: TextFormField(
                  initialValue: passwordtwo,
                  obscureText: _obscureText,
                  maxLength: 20,
                  validator: (value) => _validatePasswordTwo(value),
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget downButtons() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            RaisedButton(
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  showDialog(context: context, child: alertDialog());
                }
              },
              child: Text(
                'Aceptar',
                style: TextStyle(fontFamily: 'RobotoMono-Regular'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget alertDialog() {
    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        content: Container(
            height: 150,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Cerrar Sesión",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  flex: 1,
                ),
                Expanded(
                    flex: 3,
                    child: Text(
                      "¿Estás seguro que deseas cambiar la contraseña?",
                      textAlign: TextAlign.center,
                    )),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Cancelar"),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      RaisedButton(
                        onPressed: () {
                          navigationService.goBack();
                          changePasswordBloc
                              .add(SendNewPasswordEvent(password));
                        },
                        color: Theme.of(context).primaryColor,
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: Text(
                          "Aceptar",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )));
  }
}
