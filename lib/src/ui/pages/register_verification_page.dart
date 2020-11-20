import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pamiksa/src/blocs/blocs.dart';
import 'package:pamiksa/src/data/graphql/mutations/user.dart';
import 'package:pamiksa/src/data/models/device.dart';
import 'package:pamiksa/src/data/models/user.dart';
import 'package:pamiksa/src/data/graphql/graphql_config.dart';
import 'package:pamiksa/src/data/storage/secure_storage.dart';
import 'package:pamiksa/src/data/storage/shared.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';
import 'package:pamiksa/src/ui/themes/theme_manager.dart';

class VerificationPage extends StatefulWidget {
  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final NavigationService navigationService = locator<NavigationService>();
  final _formKey = GlobalKey<FormState>();

  RegisterVerificationBloc registerVerificationBloc;
  DeviceModel device = DeviceModel();
  UserModel user = UserModel();
  SecureStorage secureStorage = SecureStorage();

  String email;

  @override
  void initState() {
    super.initState();
    obtenerPreferences();
  }

  @override
  Widget build(BuildContext context) {
    registerVerificationBloc =
        BlocProvider.of<RegisterVerificationBloc>(context);
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Theme.of(context).primaryColorLight,
            brightness: Theme.of(context).appBarTheme.brightness,
          )),
      body: WillPopScope(
        onWillPop: () async {
          navigationService.navigateAndRemove(Routes.LoginRoute);
          return false;
        },
        child: Container(
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
                        "Verificar cuenta",
                        style: TextStyle(fontFamily: 'Roboto', fontSize: 30),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                child: Container(
                  margin: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 16.0),
                  child: Text(
                    "Te hemos enviado un código de verificación a ${email}",
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: form(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget form() {
    return Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 0.0),
          child: Column(
            children: <Widget>[
              BlocBuilder<RegisterVerificationBloc, RegisterVerificationState>(
                builder: (context, state) {
                  return BlocBuilder<RegisterVerificationBloc,
                      RegisterVerificationState>(
                    buildWhen: (previousState, state) =>
                        state.runtimeType != previousState.runtimeType,
                    builder: (context, state) {
                      if (state is RegisterVerificationInitial) {
                        return Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.center,
                            child: TextFormField(
                                maxLength: 6,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "Código de verificación",
                                ),
                                onChanged: (String value) {
                                  if (value.length == 6) {
                                    registerVerificationBloc.add(
                                        CheckVerificationCodeEvent(
                                            code: value));
                                  }
                                }),
                          ),
                        );
                      }
                      if (state is IncorrectedVerificationCodeState) {
                        return Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.center,
                            child: TextFormField(
                                maxLength: 6,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  errorText:
                                      "El código de verificación es incorrecto",
                                  labelText: "Código de verificación",
                                ),
                                onChanged: (String value) {
                                  if (value.length == 6) {
                                    registerVerificationBloc.add(
                                        CheckVerificationCodeEvent(
                                            code: value));
                                  }
                                }),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
              BlocBuilder<TimerBloc, TimerState>(
                builder: (context, state) {
                  return BlocBuilder<TimerBloc, TimerState>(
                    buildWhen: (previousState, state) =>
                        state.runtimeType != previousState.runtimeType,
                    builder: (context, state) => RegisterVerificationActions(),
                  );
                },
              ),
              Spacer(
                flex: 1,
              )
            ],
          ),
        ));
  }

  void obtenerPreferences() async {
    String correo = await secureStorage.read(key: 'email');
    setState(() {
      email = correo;
    });
  }
}

class RegisterVerificationActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _mapStateToActionButtons(
          color: Theme.of(context).primaryColor,
          timerBloc: BlocProvider.of<TimerBloc>(context),
          registerVericationBloc:
              BlocProvider.of<RegisterVerificationBloc>(context)),
    );
  }

  List<Widget> _mapStateToActionButtons({
    TimerBloc timerBloc,
    Color color,
    RegisterVerificationBloc registerVericationBloc,
  }) {
    final TimerState currentState = timerBloc.state;
    if (currentState is TimerInitial) {
      return [
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.topCenter,
            child: FlatButton.icon(
              textColor: color,
              icon: Icon(Icons.refresh),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              onPressed: () {
                timerBloc.add(TimerStarted(duration: currentState.duration));
                registerVericationBloc
                    .add(RegisterVerificationMutateCodeEvent());
              },
              label: Text("Reenviar código"),
            ),
          ),
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
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.topCenter,
            child: FlatButton.icon(
              textColor: Colors.grey,
              icon: Icon(Icons.refresh),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              label: Text("Reenviar código en $minutesStr:$secondsStr"),
            ),
          ),
        )
      ];
    }
    return [];
  }
}
