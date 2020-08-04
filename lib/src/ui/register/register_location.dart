import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:pamiksa/src/ui/login/login.dart';
import 'package:pamiksa/src/ui/register/register_location_form.dart';

class RegisterLocation extends StatefulWidget {
  static const URI = '/registerdata';

  @override
  FormRegisterLocationState createState() => new FormRegisterLocationState();
}

class FormRegisterLocationState extends State<RegisterLocation> {
  final _formKey = GlobalKey<FormState>();
  final _passKey = GlobalKey<FormFieldState<String>>();

  bool _obscureText = true;
  List<String> _provincias = ['Matanzas'];
  List<String> _municipios = ['Cárdenas'];
  String _selectedprovincia;
  String _selectedmunicipio;

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

  String _nombre;
  String _direccion;
  String _password;
  String _passwordtwo;

  @override
  Widget build(BuildContext context) {
    final cursorColor = Theme.of(context).primaryColor;
    const sizedBoxSpace = SizedBox(height: 50);

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: AppBar(
              elevation: 0.0,
              backgroundColor: Color(0xffF5F5F5),
              brightness: Brightness.light,
            )),
        body: RegisterLocationForm(),
      );
  }
}

Route _createRouter() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          RegisterLocation(),
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
