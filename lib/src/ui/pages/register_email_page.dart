import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/register_email/register_email_bloc.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';

class RegisterEmailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new RegisterEmailPageState();
}

class RegisterEmailPageState extends State<RegisterEmailPage> {
  final NavigationService navigationService = locator<NavigationService>();
  final _formKey = GlobalKey<FormState>();

  RegisterEmailBloc registerEmailBloc;

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
    registerEmailBloc = BlocProvider.of<RegisterEmailBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomPadding: false,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: AppBar(
              elevation: 0.0,
              backgroundColor: Theme.of(context).primaryColorLight,
              brightness: Theme.of(context).appBarTheme.brightness,
            )),
        body: BlocBuilder<RegisterEmailBloc, RegisterEmailState>(
          buildWhen: (previous, current) =>
              previous.runtimeType != current.runtimeType,
          builder: (context, state) {
            if (state is RegisterEmailLoadingState) {
              return Container(
                child: Column(
                  children: <Widget>[
                    LinearProgressIndicator(),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: FittedBox(
                            child: Text(
                              "Crear cuenta",
                              style:
                                  TextStyle(fontFamily: 'Roboto', fontSize: 30),
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
                    downButtons()
                  ],
                ),
              );
            }
            return Container(
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
                            style:
                                TextStyle(fontFamily: 'Roboto', fontSize: 30),
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
                  downButtons()
                ],
              ),
            );
          },
        ));
  }

  Widget form() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 0.0),
        child: Column(
          children: [
            BlocBuilder<RegisterEmailBloc, RegisterEmailState>(
              builder: (context, state) {
                if (state is RegisterEmailInitial) {
                  return Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center,
                      child: TextFormField(
                        initialValue: email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          errorMaxLines: 3,
                          helperText: "",
                          icon: Icon(Icons.email),
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
                        onChanged: (String value) {
                          email = value;
                        },
                      ),
                    ),
                  );
                } else if (state is RegisterEmailLoadingState) {
                  return Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center,
                      child: TextFormField(
                        initialValue: email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          errorMaxLines: 3,
                          helperText: "",
                          icon: Icon(Icons.email),
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
                        onChanged: (String value) {
                          email = value;
                        },
                      ),
                    ),
                  );
                }
                if (state is ExistsUserEmailState) {
                  return Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.center,
                      child: TextFormField(
                        initialValue: email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          errorMaxLines: 3,
                          helperText: "",
                          errorText:
                              "¡Ya existe una cuenta usando este correo electrónico! Prueba con otro.",
                          icon: Icon(Icons.email),
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
                        onChanged: (String value) {
                          email = value;
                        },
                      ),
                    ),
                  );
                }
              },
            ),
            Spacer(
              flex: 1,
            )
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
                  registerEmailBloc.add(CheckUserEmailEvent(email));
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
