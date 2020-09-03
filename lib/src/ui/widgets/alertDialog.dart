import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pamiksa/src/data/utils.dart';
import 'package:pamiksa/src/ui/views/login/login.dart';

SharedPref pref = new SharedPref();

alertDialogLogOut(BuildContext context) {
  return showDialog(
    context: context,
    builder: (_) {
      return BeautifulAlertDialog();
    },
  );
}

class BeautifulAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.only(right: 16.0),
          height: 150,
          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(75),
                  bottomLeft: Radius.circular(75),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          child: Row(
            children: <Widget>[
              SizedBox(width: 20.0),
              CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.grey.shade200,
                  child: Icon(Icons.settings_power)),
              SizedBox(width: 20.0),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("¡Alerta!",
                        style: TextStyle(
                          fontSize: 30.0,
                        )),
                    SizedBox(height: 10.0),
                    Flexible(
                      child: Text("¿ Esta seguro que desea CERRAR SESSIÓN ?"),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            child: Text("No"),
                            color: Colors.red,
                            colorBrightness: Brightness.dark,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          child: RaisedButton(
                            child: Text("Si"),
                            color: Colors.green,
                            colorBrightness: Brightness.dark,
                            onPressed: () {
                              pref.remove('token');
                              Navigator.of(context).pop();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => LoginPage()));
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
