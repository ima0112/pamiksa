import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/register_password/register_password_bloc.dart';
import 'package:pamiksa/src/data/storage/shared.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
import 'package:pamiksa/src/ui/navigation/route_paths.dart' as routes;
import 'package:pamiksa/src/ui/themes/theme_manager.dart';

class RegisterPasswordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new RegisterPasswordPageState();
}

class RegisterPasswordPageState extends State<RegisterPasswordPage> {
  final NavigationService navigationService = locator<NavigationService>();
  final _formKey = GlobalKey<FormState>();
  final _passKey = GlobalKey<FormFieldState<String>>();

  RegisterPasswordBloc registerPasswordBloc;

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
    registerPasswordBloc = BlocProvider.of<RegisterPasswordBloc>(context);
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Theme.of(context).primaryColorLight,
            brightness: Theme.of(context).appBarTheme.brightness,
          )),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FittedBox(
                    child: Text(
                      "Crear cuenta",
                      style: TextStyle(fontFamily: 'Roboto', fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
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
                style: TextStyle(color: Theme.of(context).primaryColor),
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
                  registerPasswordBloc.add(SaveUserPasswordEvent(password));
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
    );
  }
}
