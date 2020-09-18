import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/sign_in/sign_in_bloc.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
import 'package:pamiksa/src/ui/views/login/sign_in_form.dart';
import 'package:flutter/services.dart';
import 'package:pamiksa/src/ui/navigation/route_paths.dart' as routes;

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  SignInBloc signInBloc;

  @override
  void initState() {
    signInBloc = BlocProvider.of<SignInBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Theme.of(context).primaryColor,
            brightness: Brightness.dark,
          )),
      backgroundColor: Colors.white,
      body: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is ConnectionFailedState) {
            Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Parece que tienes un problema con la conexión"),
                duration: Duration(seconds: 5)));
          }
          if (state is CredentialsErrorState) {
            Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Credenciales incorrectas"),
                duration: Duration(seconds: 5)));
          }
        },
        builder: (BuildContext context, SignInState state) {
          if (state is LoadingSignState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 20.0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      "assets/images/pamiksa_logo_violeta_sin_fondo.png",
                      width: 80,
                      height: 80,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text("Pamiksa",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                            letterSpacing: 1.0)),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  FormLogin(),
                  Spacer(
                    flex: 1,
                  ),
                  Center(
                    child: Text(
                      '¿ Has olvidado tu contraseña ?',
                      style: TextStyle(
                          color: Color(0xff6200EA),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 7.5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '¿ No tiene un usuario ? ',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        child: Text(
                          "Crear cuenta",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          signInBloc.add(GetRegisterDataEvent());
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
