import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'file:///C:/Users/Imandra/AndroidStudioProjects/pamiksa/lib/src/providers/themes/consts.dart'
    show COLORPRIMARYLIGTH, REGISTRER_SMS;
import 'package:pamiksa/src/ui/login/login.dart';

class Register extends StatefulWidget {
  static const URI = '/register';

  @override
  FormRegisterState createState() => new FormRegisterState();
}

class FormRegisterState extends State<Register> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _passKey = GlobalKey<FormFieldState<String>>();
  List<String> _provincias = ['Matanzas', 'La Habana'];
  List<String> _municipios = ['Cárdenas'];
  String _selectedprovincia;
  String _selectedmunicipio;
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
    if (pass.value != value || value.length < 8) {
      return '¡Las contraseñas no coinciden!';
    }
    return null;
  }

  _validateNombre(String value) {
    if (value.isEmpty) {
      return '¡Ingrese su nombre!';
    }
  }

  _validateProvincia(String value) {
    if (value.isEmpty) {
      return '¡Ingrese una provincia!';
    }
  }

  _validateMunicipio(String value) {
    if (value.isEmpty) {
      return '¡Ingrese un municipio!';
    }
  }

  _validateDireccion(String value) {
    if (value.isEmpty) {
      return '¡Ingrese una dirección!';
    }
  }

  String _nombre;
  String _provincia;
  String _municipio;
  String _direccion;
  String _password;
  String _passwordtwo;

  @override
  Widget build(BuildContext context) {
    final cursorColor = Theme.of(context).primaryColor;
    const sizedBoxSpace = SizedBox(height: 24);

    return MaterialApp(
      theme: ThemeData(primaryColor: Theme.of(context).primaryColor),
      home: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: AppBar(
              elevation: 0.0,
              backgroundColor: Color(0xffF5F5F5),
              brightness: Brightness.light,
            )),
        body: Center(
          child: Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 16.0),
              padding: EdgeInsets.only(
                  top: 50.0, bottom: 0, right: 16.0, left: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  sizedBoxSpace,
                  Text(
                    "Crear cuenta",
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 30),
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: cursorColor,
                    style: TextStyle(
                        fontFamily: 'RobotoMono-Regular',
                        color: Colors.black54,
                        fontSize: 16),
                    decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      filled: false,
                      fillColor: Colors.white24,
                      labelText: "Correo electrónico",
                      labelStyle: TextStyle(fontFamily: 'RobotoMono-Regular'),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor, width: 2)),
                    ),
                    onSaved: (value) {
                      _nombre = value;
                    },
                    validator: (value) => _validateEmail(value),
                  ),
                  TextFormField(
                    key: _passKey,
                    cursorColor: cursorColor,
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
                    onChanged: (String value) {
                      setState(() {
                        _password = value;
                      });
                    },
                  ),
                  TextFormField(
                    cursorColor: cursorColor,
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
                        _passwordtwo = value;
                      });
                    },
                  ),
                  sizedBoxSpace,
                  Divider(),
                  Row(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(_createRouter());
                          },
                          child: Text(
                            "ATRÁS",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 130,
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content:
                                    Text('Usuario o Contraseña incorrectos'),
                              ));
                            }
                          },
                          child: Text(
                            'SIGUIENTE',
                            style: TextStyle(fontFamily: 'RobotoMono-Regular'),
                          ),
                        ),
                      ),
                    ],
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

Route _createRouter() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
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
