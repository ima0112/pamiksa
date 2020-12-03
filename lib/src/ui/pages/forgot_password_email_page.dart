import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/blocs.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';

class ForgotPasswordEmailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new ForgotPasswordEmailPageState();
}

class ForgotPasswordEmailPageState extends State<ForgotPasswordEmailPage> {
  final NavigationService navigationService = locator<NavigationService>();
  final _formKey = GlobalKey<FormState>();

  ForgotPasswordEmailBloc forgotpasswordEmailBloc;

  String email;

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    forgotpasswordEmailBloc = BlocProvider.of<ForgotPasswordEmailBloc>(context);
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 5.0),
            child:
                BlocBuilder<ForgotPasswordEmailBloc, ForgotPasswordEmailState>(
              builder: (context, state) {
                if (state is LoadingForgotPasswordState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Container(
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
                                  child: Column(children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    BlocBuilder<ForgotPasswordEmailBloc,
                                        ForgotPasswordEmailState>(
                                      builder: (context, state) {
                                        if (state
                                            is ForgotPasswordEmailInitial) {
                                          return TextFormField(
                                            initialValue: email,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            decoration: InputDecoration(
                                              errorMaxLines: 3,
                                              helperText: "",
                                              icon: Icon(Icons.email),
                                              fillColor: Colors.white24,
                                              labelText: "Correo electrónico",
                                              labelStyle: TextStyle(
                                                  fontFamily:
                                                      'RobotoMono-Regular'),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          width: 2)),
                                            ),
                                            validator: (value) =>
                                                _validateEmail(value),
                                            onChanged: (String value) {
                                              email = value;
                                            },
                                          );
                                        }
                                        if (state is NotExistsUserEmailState) {
                                          return TextFormField(
                                            initialValue: email,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            style: TextStyle(
                                                fontFamily:
                                                    'RobotoMono-Regular',
                                                color: Colors.black54,
                                                fontSize: 16),
                                            decoration: InputDecoration(
                                              errorMaxLines: 3,
                                              errorText:
                                                  "¡No existe una cuenta usando este correo electrónico! Prueba con otro.",
                                              helperText: "",
                                              icon: Icon(Icons.email),
                                              filled: false,
                                              fillColor: Colors.white24,
                                              labelText: "Correo electrónico",
                                              labelStyle: TextStyle(
                                                  fontFamily:
                                                      'RobotoMono-Regular'),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          width: 2)),
                                            ),
                                            validator: (value) =>
                                                _validateEmail(value),
                                            onChanged: (String value) {
                                              email = value;
                                            },
                                          );
                                        }
                                      },
                                    )
                                  ])),
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
                                  forgotpasswordEmailBloc.add(
                                      CheckPasswordByUserEmailEvent(email));
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
                );
              },
            )));
  }
}
