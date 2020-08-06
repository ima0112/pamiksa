import 'package:flutter/material.dart';

class RegisterDataForm extends StatefulWidget {
  @override
  RegisterDataFormState createState() => RegisterDataFormState();
}

class RegisterDataFormState extends State<RegisterDataForm> {
  final _passKey = GlobalKey<FormFieldState<String>>();

  String correo;
  String password;
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
    const sizedBoxSpace = SizedBox(height: 25);

    return Container(
      margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
      child: Column(
        children: [
          SizedBox(height: 5,),
          TextFormField(
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
              labelStyle: TextStyle(fontFamily: 'RobotoMono-Regular'),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 2)),
            ),
            onSaved: (value) {
              correo = value;
            },
            validator: (value) => _validateEmail(value),
          ),
          sizedBoxSpace,
          TextFormField(
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
                child: new Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off),
              ),
            ),
            onChanged: (String value) {
              setState(() {
                password = value;
              });
            },
          ),
          sizedBoxSpace,
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
    );
  }
}
