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
  final NavigationService navigationService = locator<NavigationService>();
  SignInBloc signInBloc;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    signInBloc = BlocProvider.of<SignInBloc>(context);
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
      body: BlocListener<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is ConnectionFailedState) {
            Scaffold.of(context).showSnackBar(SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(Icons.warning),
                    Text("Parece que tienes un problema con la conexión"),
                  ],
                ),
                backgroundColor: Colors.black54,
                duration: Duration(seconds: 2)));
          }
          if (state is CredentialsErrorState) {
            Scaffold.of(context).showSnackBar(SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(Icons.warning),
                    Text(
                        "El correo electrónico o la contraseña son incorrectos"),
                  ],
                ),
                backgroundColor: Colors.black54,
                duration: Duration(seconds: 2)));
          }
        },
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Image.asset(
                  "assets/images/pamiksa_logo_violeta_sin_fondo.png",
                  width: 80,
                  height: 80,
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Pamiksa",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        letterSpacing: 1.0)),
                SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: FormLogin(),
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
                        signInBloc.add(CheckConnectionEvent());
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
