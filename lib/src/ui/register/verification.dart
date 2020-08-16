import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';

class VerificationPage extends StatefulWidget {
  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isButtonDisabled;
  String code;
  Map data;
  Timer _timer;
  static int _start = 60;
  String minutesStr = ((_start / 60) % 60).floor().toString().padLeft(2, '0');
  String secondsStr = (_start % 60).floor().toString().padLeft(2, '0');

  _validateCode(String value) {
    if (value.isEmpty) {
      return "¡Ingrese un código!";
    }
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            _isButtonDisabled = false;
            timer.cancel();
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
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Color(0xffF5F5F5),
            brightness: Brightness.light,
          )),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 10.0),
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
                      "Te hemos enviado un código de verificación a ${data['email']}",
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
                        child: TextFormField(
                          maxLength: 6,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Código de verificación",
                          ),
                          onChanged: (String value) {
                            setState(() {
                              code = value;
                            });
                          },
                          validator: (value) => _validateCode(value),
                        ),
                      ),
                    ),
                  ),
                ),
                RaisedButton(
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  onPressed: _isButtonDisabled ? null : startTimer,
                  child: Text(
                    'REENVIAR CÓDIGO',
                    style: TextStyle(
                        fontFamily: 'RobotoMono-Regular',
                        fontWeight: FontWeight.w900),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text("Reenviar código en ${minutesStr}: ${secondsStr}",
                    style: TextStyle(color: Colors.black45)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
