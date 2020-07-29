import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:pamiksa/consts.dart' show COLORPRIMARYLIGTH, REGISTRER_SMS;

class Register extends StatefulWidget {
  static const URI = '/register';

  @override
  FormRegisterState createState() => new FormRegisterState();
}

class FormRegisterState extends State<Register> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
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
      return '¡La contraseña debe poseer al menos 8 caracteres!';
    }
    return null;
  }

  String _nombre;
  String _provincia;
  String _municipio;
  String _direccion;

  @override
  Widget build(BuildContext context) {
    final cursorColor = COLORPRIMARYLIGTH;
    const sizedBoxSpace = SizedBox(height: 24);
    const color = COLORPRIMARYLIGTH;

    return MaterialApp(
      theme: ThemeData(primaryColor: COLORPRIMARYLIGTH),
      home: Scaffold(
        body: Center(
          child: Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 16.0),
              padding: EdgeInsets.only(
                  top: 50.0, bottom: 0, right: 16.0, left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  sizedBoxSpace,
                  Text(
                    REGISTRER_SMS,
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    cursorColor: cursorColor,
                    style: TextStyle(fontFamily: 'RobotoMono-Regular'),
                    decoration: InputDecoration(
                      filled: false,
                      fillColor: Colors.white24,
                      labelText: "Nombre*",
                      labelStyle: TextStyle(fontFamily: 'RobotoMono-Regular'),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: color, width: 2)),
                    ),
                    onSaved: (value) {
                      _nombre = value;
                    },
                    validator: (value) => _validateEmail(value),
                  ),
                  TextFormField(
                    cursorColor: cursorColor,
                    style: TextStyle(fontFamily: 'RobotoMono-Regular'),
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      filled: false,
                      labelText: "Provincia*",
                      labelStyle: TextStyle(fontFamily: 'RobotoMono-Regular'),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: color, width: 2)),
                    ),
                    onSaved: (value) {
                      _provincia = value;
                    },
                    validator: (value) => _validateEmail(value),
                  ),
                  TextFormField(
                    cursorColor: cursorColor,
                    style: TextStyle(fontFamily: 'RobotoMono-Regular'),
                    decoration: InputDecoration(
                      filled: false,
                      labelText: "Municipio*",
                      labelStyle: TextStyle(fontFamily: 'RobotoMono-Regular'),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: color, width: 2)),
                    ),
                    onSaved: (value) {
                      _municipio = value;
                    },
                    validator: (value) => _validateEmail(value),
                  ),
                  TextFormField(
                    cursorColor: cursorColor,
                    style: TextStyle(fontFamily: 'RobotoMono-Regular'),
                    decoration: InputDecoration(
                      filled: false,
                      labelText: "Dirección*",
                      labelStyle: TextStyle(fontFamily: 'RobotoMono-Regular'),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: color, width: 2),
                      ),
                    ),
                    onSaved: (value) {
                      _direccion = value;
                    },
                  ),
                  sizedBoxSpace,
                  Container(
                    height: 45,
                    width: 320,
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      onPressed: () {},
                      child: Text(
                        'REGISTRARME',
                        style: TextStyle(
                            fontFamily: 'RobotoMono-Regular',
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                  sizedBoxSpace,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
