import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pamiksa/src/blocs/forgot_password_verification/forgot_password_verification_bloc.dart';

import 'package:pamiksa/src/data/graphql/mutations/user.dart';
import 'package:pamiksa/src/data/models/device.dart';
import 'package:pamiksa/src/data/models/user.dart';
import 'package:pamiksa/src/data/graphql/graphql_config.dart';
import 'package:pamiksa/src/data/storage/secure_storage.dart';
import 'package:pamiksa/src/data/storage/shared.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
import 'package:pamiksa/src/ui/navigation/route_paths.dart' as routes;
import 'package:pamiksa/src/ui/themes/theme_manager.dart';

import '../../blocs/timer/timer_bloc.dart';

class ForgotPasswordVerificationPage extends StatefulWidget {
  @override
  ForgotPasswordVerificationPageState createState() =>
      ForgotPasswordVerificationPageState();
}

class ForgotPasswordVerificationPageState
    extends State<ForgotPasswordVerificationPage> {
  final NavigationService navigationService = locator<NavigationService>();
  final _formKey = GlobalKey<FormState>();

  ForgotPasswordVerificationBloc forgotPasswordVerificationBloc;
  DeviceModel device = DeviceModel();
  UserModel user = UserModel();
  SecureStorage secureStorage = SecureStorage();

  String email;

  @override
  void initState() {
    obtenerPreferences();
    forgotPasswordVerificationBloc =
        BlocProvider.of<ForgotPasswordVerificationBloc>(context);
    forgotPasswordVerificationBloc.add(MutateCodeFromForgotPasswordEvent());
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
            backgroundColor: Theme.of(context).primaryColorLight,
            brightness: Theme.of(context).appBarTheme.brightness,
          )),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 5.0),
          child: Column(
            children: <Widget>[
              Text(
                "Verificar cuenta",
                style: TextStyle(fontFamily: 'Roboto', fontSize: 30),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                child: Container(
                  margin: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 16.0),
                  child: Text(
                    "Te hemos enviado un código de verificación a ${email}",
                    style: TextStyle(color: Colors.black45),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 16.0),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            BlocBuilder<ForgotPasswordVerificationBloc,
                                ForgotPasswordVerificationState>(
                              builder: (context, state) {
                                return BlocBuilder<
                                    ForgotPasswordVerificationBloc,
                                    ForgotPasswordVerificationState>(
                                  buildWhen: (previousState, state) =>
                                      state.runtimeType !=
                                      previousState.runtimeType,
                                  builder: (context, state) {
                                    if (state
                                        is ForgotPasswordVerificationInitial) {
                                      return TextFormField(
                                          maxLength: 6,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            labelText: "Código de verificación",
                                          ),
                                          onChanged: (String value) {
                                            if (value.length == 6) {
                                              forgotPasswordVerificationBloc.add(
                                                  CheckVerificationFromForgotPasswordCodeEvent(
                                                      value));
                                            }
                                          });
                                    }
                                    if (state
                                        is IncorrectedVerificationToForgotPasswordCodeState) {
                                      return TextFormField(
                                          maxLength: 6,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            errorText:
                                                "El código de verificación es incorrecto",
                                            labelText: "Código de verificación",
                                          ),
                                          onChanged: (String value) {
                                            if (value.length == 6) {
                                              forgotPasswordVerificationBloc.add(
                                                  CheckVerificationFromForgotPasswordCodeEvent(
                                                      value));
                                            }
                                          });
                                    }
                                  },
                                );
                              },
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            BlocBuilder<TimerBloc, TimerState>(
                              builder: (context, state) {
                                return BlocBuilder<TimerBloc, TimerState>(
                                  buildWhen: (previousState, state) =>
                                      state.runtimeType !=
                                      previousState.runtimeType,
                                  builder: (context, state) =>
                                      ForgotPasswordVerificationActions(),
                                );
                              },
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void obtenerPreferences() async {
    String correo = await secureStorage.read(key: 'email');
    setState(() {
      email = correo;
    });
  }
}

class ForgotPasswordVerificationActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _mapStateToActionButtons(
          color: Theme.of(context).primaryColor,
          timerBloc: BlocProvider.of<TimerBloc>(context),
          forgotPasswordVerificationBloc:
              BlocProvider.of<ForgotPasswordVerificationBloc>(context)),
    );
  }

  List<Widget> _mapStateToActionButtons({
    TimerBloc timerBloc,
    Color color,
    ForgotPasswordVerificationBloc forgotPasswordVerificationBloc,
  }) {
    final TimerState currentState = timerBloc.state;
    if (currentState is TimerInitial) {
      return [
        FlatButton.icon(
          textColor: color,
          icon: Icon(Icons.refresh),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          onPressed: () {
            timerBloc.add(TimerStarted(duration: currentState.duration));
            forgotPasswordVerificationBloc
                .add(MutateCodeFromForgotPasswordEvent());
          },
          label: Text("Reenviar código"),
        )
      ];
    }
    if (currentState is TimerRunInProgress) {
      final String minutesStr = ((timerBloc.state.duration / 60) % 60)
          .floor()
          .toString()
          .padLeft(2, '0');
      final String secondsStr =
          (timerBloc.state.duration % 60).floor().toString().padLeft(2, '0');
      return [
        FlatButton.icon(
          textColor: Colors.grey,
          icon: Icon(Icons.refresh),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          label: Text("Reenviar código en $minutesStr:$secondsStr"),
        )
      ];
    }
    return [];
  }
}
