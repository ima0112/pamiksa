import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/blocs.dart';
import 'package:flutter/services.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final NavigationService navigationService = locator<NavigationService>();
  final formKey = GlobalKey<FormState>();

  SignInBloc signInBloc;

  String email;
  String password;
  bool obscureText = true;

  String validateEmail(String value) {
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

  String validatePassword(String value) {
    if (value.isEmpty) {
      return '¡Ingrese una contraseña!';
    }
    if (value.length < 8) {
      return '¡Debe poseer al menos 8 caracteres!';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    signInBloc = BlocProvider.of<SignInBloc>(context);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Theme.of(context).primaryColor,
            brightness: Brightness.dark,
          )),
      body: BlocConsumer<SignInBloc, SignInState>(
        listenWhen: (previous, current) =>
            current.runtimeType != previous.runtimeType,
        listener: (context, state) {
          if (state is ConnectionFailedState) {
            Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
                  "Parece que tienes un problema con la conexión",
                  style: TextStyle(color: Colors.white),
                ),
                duration: Duration(seconds: 5)));
          }
          if (state is CredentialsErrorState) {
            Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Credenciales incorrectas",
                    style: TextStyle(color: Colors.white)),
                duration: Duration(seconds: 5)));
          }
        },
        buildWhen: (previous, current) =>
            current.runtimeType != previous.runtimeType,
        builder: (BuildContext context, SignInState state) {
          if (state is LoadingSignState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SafeArea(
            top: true,
            bottom: true,
            left: false,
            right: false,
            // child: Padding(
            //   padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 20.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: startLogin(),
                  ),
                  // Spacer(
                  //   flex: 1,
                  // ),
                  Expanded(
                      flex: 6,
                      child: Align(alignment: Alignment.center, child: form())),
                  // Spacer(
                  //   flex: 1,
                  // ),
                  Expanded(
                    flex: 2,
                    child: endLogin(),
                  )
                ],
              ),
            ),
            // ),
          );
        },
      ),
    );
  }

  Widget startLogin() {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.only(top: 25.0),
            child: Image.asset(
              "assets/images/pamiksa_logo_violeta_sin_fondo.png",
              fit: BoxFit.fill,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.topCenter,
            child: FittedBox(
              child: Text("Pamiksa",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      letterSpacing: 1.0)),
            ),
          ),
        ),
      ],
    );
  }

  Widget form() {
    return Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: TextFormField(
                    initialValue: email,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(fontSize: 16),
                    decoration: const InputDecoration(
                      hintText: 'Correo electrónico',
                      helperText: "",
                      border: UnderlineInputBorder(),
                      // labelText: 'Correo electrónico',
                      filled: false,
                      icon: Icon(Icons.email),
                    ),
                    onChanged: (String value) {
                      email = value;
                    },
                    validator: (value) => validateEmail(value),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: TextFormField(
                    initialValue: password,
                    obscureText: obscureText,
                    maxLength: 20,
                    validator: (value) => validatePassword(value),
                    decoration: new InputDecoration(
                      hintText: 'Contraseña',
                      helperText: "",
                      border: const UnderlineInputBorder(),
                      filled: false,
                      // labelText: 'Contraseña',
                      icon: Icon(Icons.lock),
                      suffixIcon: new GestureDetector(
                        onTap: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        child: new Icon(obscureText
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                    ),
                    onChanged: (String value) {
                      password = value;
                    },
                  ),
                ),
              ),
              // SizedBox(
              //   height: 40,
              // ),
              Expanded(
                flex: 2,
                child: loginButton(),
              )
            ],
          ),
        ));
  }

  Widget loginButton() {
    return BlocBuilder<SignInBloc, SignInState>(
      buildWhen: (previous, current) =>
          current.runtimeType != previous.runtimeType,
      builder: (context, state) {
        if (state is WaitingSignInResponseState) {
          return Center(child: CircularProgressIndicator());
        }
        return Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(bottom: 15.0),
            child: RaisedButton(
              child: Text("INICIAR SESIÓN"),
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              onPressed: () async {
                if (formKey.currentState.validate()) {
                  signInBloc
                      .add(MutateSignInEvent(email: email, password: password));
                }
              },
              elevation: 0,
            ),
          ),
        );
      },
    );
  }

  Widget endLogin() {
    return Column(children: [
      Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: () {
            navigationService.navigateTo(Routes.ForgotPasswordEmail);
          },
          child: Align(
            alignment: Alignment.topCenter,
            child: FittedBox(
              child: Text(
                '¿ Has olvidado tu contraseña ?',
                style: TextStyle(
                    color: Color(0xff6200EA),
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
      Expanded(
        flex: 2,
        child: Padding(
          padding: EdgeInsets.only(bottom: 15.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: FittedBox(
              child: Text.rich(TextSpan(children: [
                TextSpan(
                    text: '¿No tienes cuenta?  ',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1.color,
                        fontSize: 14,
                        fontWeight: FontWeight.bold)),
                TextSpan(
                  text: 'Create una cuenta',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ])),
            ),
          ),
        ),
      )
    ]);
  }
}
