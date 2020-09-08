import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/sign_in/sign_in_bloc.dart';

class FormLogin extends StatefulWidget {
  @override
  FormLoginState createState() => new FormLoginState();
}

class FormLoginState extends State<FormLogin> with TickerProviderStateMixin {
  SignInBloc signInBloc;
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
  dynamic returnData;

  @override
  Widget build(BuildContext context) {
    signInBloc = BlocProvider.of<SignInBloc>(context);
    return Form(
        key: _formKey,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
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
                  _email = value;
                },
                validator: (value) => _validateEmail(value),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
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
                    child: new Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility),
                  ),
                ),
                onChanged: (String value) {
                  _password = value;
                },
              ),
              SizedBox(
                height: 60,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: BlocBuilder<SignInBloc, SignInState>(
                    builder: (context, state) {
                  if (state is SignInInitial) {
                    return RaisedButton(
                      child: Text("INICIAR SESIÓN"),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          signInBloc.add(MutateSignInEvent(
                              email: _email, password: _password));
                        }
                      },
                      elevation: 0,
                    );
                  } else if (state is CredentialsErrorState) {
                    return RaisedButton.icon(
                      icon: Icon(Icons.refresh),
                      label: Text("REINTENTAR"),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          signInBloc.add(MutateSignInEvent(
                              email: _email, password: _password));
                        }
                      },
                      elevation: 0,
                    );
                  } else if (state is WaitingSignInResponseState) {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
              ),
            ],
          ),
        ));
  }
}
