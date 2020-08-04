import 'package:flutter/material.dart';

class RegisterDataForm extends StatefulWidget {
  @override
  RegisterDataFormState createState() => RegisterDataFormState();
}

class RegisterDataFormState extends State<RegisterDataForm> {
  final _passKey = GlobalKey<FormFieldState<String>>();

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

  _validateDireccion(String value) {
    if (value.isEmpty) {
      return '¡Ingrese una dirección!';
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

    return Container(
      margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
      child: Column(
        children: [
          SizedBox(height: 5,),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            cursorColor: cursorColor,
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
          SizedBox(
            height: 25,
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
                child: new Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off),
              ),
            ),
            onChanged: (String value) {
              setState(() {
                _password = value;
              });
            },
          ),
          SizedBox(
            height: 25,
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
        ],
      ),
    );
  }
}
