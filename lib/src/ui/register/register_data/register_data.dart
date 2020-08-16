import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:pamiksa/src/ui/register/register_data_person/register.dart';
import 'package:pamiksa/src/ui/register/register_data/register_data_form.dart';

class RegisterDataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return RegisterData();
  }
}

class RegisterData extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new RegisterDataState();
}

class RegisterDataState extends State<RegisterData> {
  final _formKey = GlobalKey<FormState>();
  final _passKey = GlobalKey<FormFieldState<String>>();
  final _correoCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  String passwordtwo;
  bool _obscureText = true;

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
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Color(0xffF5F5F5),
            brightness: Brightness.light,
          )),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 5.0),
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                child: Text(
                  "Crear cuenta",
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
                        padding: const EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              controller: _correoCtrl,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                  fontFamily: 'RobotoMono-Regular',
                                  color: Colors.black54,
                                  fontSize: 16),
                              decoration: InputDecoration(
                                helperText: "",
                                icon: Icon(Icons.email),
                                filled: false,
                                fillColor: Colors.white24,
                                labelText: "Correo electrónico",
                                labelStyle:
                                    TextStyle(fontFamily: 'RobotoMono-Regular'),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 2)),
                              ),
                              validator: (value) => _validateEmail(value),
                            ),
                            // sizedBoxSpace,
                            TextFormField(
                              controller: _passwordCtrl,
                              key: _passKey,
                              style: TextStyle(
                                  fontFamily: 'RobotoMono-Regular',
                                  color: Colors.black54,
                                  fontSize: 16),
                              obscureText: _obscureText,
                              maxLength: 20,
                              validator: (value) => _validatePassword(value),
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
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                              ),
                            ),
                            TextFormField(
                              style: TextStyle(
                                  fontFamily: 'RobotoMono-Regular',
                                  color: Colors.black54,
                                  fontSize: 16),
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
                                setState(() {
                                  passwordtwo = value;
                                });
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
                        Navigator.pop(context);
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
                          Navigator.pushNamed(context, "/register_data_person",
                              arguments: {
                                'email': "${_correoCtrl.text}",
                                'password': "${_passwordCtrl.text}"
                              });
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
      ),
    );
  }
}

Route _createRouter() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          RegisterDataPersonPage(),
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
