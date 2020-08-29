import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_info/device_info.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pamiksa/src/data/graphql/mutations/sendVerificationCode.dart';
import 'package:pamiksa/src/data/graphql/mutations/sendDeviceInfo.dart';
import 'package:pamiksa/src/data/graphql/mutations/signUp.dart';
import 'package:pamiksa/src/data/models/device.dart';
import 'package:pamiksa/src/data/models/user.dart';
import 'package:pamiksa/src/data/graphql/graphqlConfig.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerificationPage extends StatefulWidget {
  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final _formKey = GlobalKey<FormState>();
  Device device = Device();
  bool _isButtonDisabled;
  bool _isTimerOver;
  Timer _timer;
  static int _start = 60;
  String minutesStr = ((_start / 60) % 60).floor().toString().padLeft(2, '0');
  String secondsStr = (_start % 60).floor().toString().padLeft(2, '0');
  User user = User();
  bool _isLoading = false;
  bool _hasError = false;
  String correo;
  String code;
  String verificationCode;
  int newCode;
  String _userId;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            _isTimerOver = true;
            _start = 60;
          } else {
            minutesStr =
                ((_start / 60) % 60).floor().toString().padLeft(2, '0');
            secondsStr = (_start % 60).floor().toString().padLeft(2, '0');
            _start = _start - 1;
          }
        },
      ),
    );
  }

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
    return GraphQLProvider(
      client: GraphQLConfiguration.client,
      child: CacheProvider(
        child: Scaffold(
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
                        "Te hemos enviado un código de verificación a ${user.email}",
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
                                TextFormField(
                                    initialValue: code,
                                    maxLength: 6,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      errorText: _hasError
                                          ? "El código de verificación es incorrecto"
                                          : null,
                                      labelText: "Código de verificación",
                                    ),
                                    onChanged: (String value) {
                                      code = value;
                                      if (code.length == 6 &&
                                          code == verificationCode.toString()) {
                                        setState(() {
                                          if (_hasError == true) {
                                            _hasError = false;
                                          }
                                          _isButtonDisabled = false;
                                        });
                                        print("ok");
                                      } else if (code.length == 6 &&
                                          code != verificationCode.toString()) {
                                        setState(() {
                                          _hasError = true;
                                          _isButtonDisabled = true;
                                        });
                                      } else if (code.length < 6) {
                                        setState(() {
                                          _isButtonDisabled = true;
                                        });
                                      }
                                    }),
                                SizedBox(
                                  height: 25,
                                ),
                                Mutation(
                                  options: MutationOptions(
                                      documentNode: gql(sendVerificationCode)),
                                  builder: (RunMutation runMutation,
                                      QueryResult result) {
                                    return FlatButton.icon(
                                      textColor: _isTimerOver
                                          ? Theme.of(context).primaryColor
                                          : Colors.grey,
                                      icon: Icon(Icons.refresh),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      onPressed: _isTimerOver
                                          ? () {
                                              startTimer();
                                              setState(() {
                                                if (_hasError == true) {
                                                  _hasError = false;
                                                }
                                                _isTimerOver = false;
                                                _isButtonDisabled = true;
                                                code = null;
                                              });
                                              randomCode();
                                              runMutation({
                                                'code': newCode,
                                                'email': user.email
                                              });
                                              print(newCode);
                                            }
                                          : null,
                                      label: Text(
                                        _isTimerOver
                                            ? "Reenviar código"
                                            : "Reenviar código en ${minutesStr}: ${secondsStr}",
                                      ),
                                    );
                                  },
                                )
                              ],
                            )),
                      ),
                    ),
                  ),
                  Divider(),
                  Container(
                    margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                    padding: EdgeInsets.only(
                        top: 0.0, bottom: 0.0, right: 16.0, left: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Mutation(
                          options: MutationOptions(
                              documentNode: gql(singUp),
                              onCompleted: (dynamic resultData) {
                                if (resultData != null) {
                                  _userId =
                                      (resultData['signUp']['user']['id']);
                                  saveId();
                                  Navigator.pushNamed(
                                      context, "/register_complete");
                                } else {
                                  print('No data from request');
                                }
                              }),
                          builder:
                              (RunMutation runMutation, QueryResult result) {
                            return RaisedButton(
                              textColor: Colors.white,
                              color: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              onPressed: _isButtonDisabled
                                  ? null
                                  : () {
                                      runMutation({
                                        'fullName': user.fullName,
                                        'email': user.email,
                                        'password': user.password,
                                        'birthday': user.birthday,
                                        'adress': user.adress,
                                        'provinceFk': 1,
                                        'municipalityFk': 1
                                      });
                                    },
                              child: Text(
                                'SIGUIENTE',
                                style:
                                    TextStyle(fontFamily: 'RobotoMono-Regular'),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  addData(int random) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('code', random.toString());
  }

  void randomCode() async {
    int min = 100000;
    int max = 999999;
    var randomizer = new Random();
    newCode = min + randomizer.nextInt(max - min);
    addData(newCode);
  }

  void obtenerPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      verificationCode = preferences.get('code');
      user.fullName = preferences.get('name');
      user.password = preferences.get('password');
      user.adress = preferences.get('adress');
      user.birthday = preferences.get('birthday');
      user.email = preferences.get('email');
    });
  }

  void saveId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('user_id', _userId);
  }
}
