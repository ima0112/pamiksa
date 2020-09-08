import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pamiksa/src/blocs/timer/timer_bloc.dart';
import 'package:pamiksa/src/blocs/register_verification/register_verification_bloc.dart';
import 'package:pamiksa/src/data/graphql/mutations/user.dart';
import 'package:pamiksa/src/data/models/device.dart';
import 'package:pamiksa/src/data/models/user.dart';
import 'package:pamiksa/src/data/graphql/graphql_config.dart';
import 'package:pamiksa/src/data/shared/shared.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
import 'package:pamiksa/src/ui/navigation/route_paths.dart' as routes;

class VerificationPage extends StatefulWidget {
  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  RegisterVerificationBloc registerVerificationBloc;
  final NavigationService navigationService = locator<NavigationService>();
  final _formKey = GlobalKey<FormState>();

  DeviceModel device = DeviceModel();
  Shared preferences = Shared();
  UserModel user = UserModel();
  Timer _timer;

  String email;
  String verificationCode;
  String _userId;

  bool _isLoading = false;
  bool _hasError = false;
  bool _isButtonDisabled;
  bool _isTimerOver;

  int newCode;

  @override
  void initState() {
    super.initState();
    _isButtonDisabled = true;
    _isTimerOver = true;
    obtenerPreferences();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    registerVerificationBloc =
        BlocProvider.of<RegisterVerificationBloc>(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Color(0xffF5F5F5),
            brightness: Brightness.light,
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
                            BlocBuilder<RegisterVerificationBloc,
                                RegisterVerificationState>(
                              builder: (context, state) {
                                return BlocBuilder<RegisterVerificationBloc,
                                    RegisterVerificationState>(
                                  buildWhen: (previousState, state) =>
                                      state.runtimeType !=
                                      previousState.runtimeType,
                                  builder: (context, state) {
                                    if (state is RegisterVerificationInitial) {
                                      return TextFormField(
                                          maxLength: 6,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            labelText: "Código de verificación",
                                          ),
                                          onChanged: (String value) {
                                            if (value.length == 6) {
                                              registerVerificationBloc.add(
                                                  CheckVerificationCodeEvent(
                                                      value));
                                            }
                                            // code = value;
                                            // if (code.length == 6 &&
                                            //     code ==
                                            //         verificationCode
                                            //             .toString()) {
                                            //   setState(() {
                                            //     if (_hasError == true) {
                                            //       _hasError = false;
                                            //     }
                                            //     _isButtonDisabled = false;
                                            //   });
                                            //   print("ok");
                                            // } else if (code.length == 6 &&
                                            //     code !=
                                            //         verificationCode
                                            //             .toString()) {
                                            //   setState(() {
                                            //     _hasError = true;
                                            //     _isButtonDisabled = true;
                                            //   });
                                            // } else if (code.length < 6) {
                                            //   setState(() {
                                            //     _isButtonDisabled = true;
                                            //   });
                                            // }
                                          });
                                    }
                                    if (state
                                        is IncorrectedVerificationCodeState) {
                                      return TextFormField(
                                          maxLength: 6,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            errorText:
                                                "El código de verificación es incorrecto",
                                            labelText: "Código de verificación",
                                          ),
                                          onChanged: (String value) {
                                            registerVerificationBloc.add(
                                                CheckVerificationCodeEvent(
                                                    value));
                                            // code = value;
                                            // if (code.length == 6 &&
                                            //     code ==
                                            //         verificationCode
                                            //             .toString()) {
                                            //   setState(() {
                                            //     if (_hasError == true) {
                                            //       _hasError = false;
                                            //     }
                                            //     _isButtonDisabled = false;
                                            //   });
                                            //   print("ok");
                                            // } else if (code.length == 6 &&
                                            //     code !=
                                            //         verificationCode
                                            //             .toString()) {
                                            //   setState(() {
                                            //     _hasError = true;
                                            //     _isButtonDisabled = true;
                                            //   });
                                            // } else if (code.length < 6) {
                                            //   setState(() {
                                            //     _isButtonDisabled = true;
                                            //   });
                                            // }
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
                                  builder: (context, state) => Actions(),
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
    String correo = await preferences.read('email');
    setState(() {
      email = correo;
    });
  }
}

class Actions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _mapStateToActionButtons(
          color: Theme.of(context).primaryColor,
          timerBloc: BlocProvider.of<TimerBloc>(context),
          registerVeriicationBloc:
              BlocProvider.of<RegisterVerificationBloc>(context)),
    );
  }

  List<Widget> _mapStateToActionButtons({
    TimerBloc timerBloc,
    Color color,
    RegisterVerificationBloc registerVeriicationBloc,
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
            registerVeriicationBloc.add(MutateCodeEvent());
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
