import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/home/home_bloc.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  HomeBloc homeBloc;
  final NavigationService navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    homeBloc = BlocProvider.of<HomeBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Configuración",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1.0,
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.account_circle, color: Colors.black),
            title: Text("Cuenta"),
            onTap: () {},
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15.0,
            ),
          ),
          ListTile(
            leading: Icon(Icons.credit_card, color: Colors.black),
            title: Text("Pedidos"),
            onTap: () {},
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15.0,
            ),
          ),
          ListTile(
            leading: Icon(Icons.palette, color: Colors.black),
            title: Text("Tema"),
            onTap: () {},
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15.0,
            ),
          ),
          ListTile(
            leading: Icon(Icons.help_outline, color: Colors.black),
            title: Text("Ayuda"),
            onTap: () {},
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15.0,
            ),
          ),
          ListTile(
            leading: Icon(Icons.input, color: Colors.black),
            title: Text("Cerrar sesión"),
            onTap: () {
              AlertDialog alertDialog = AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  content: Container(
                      //color: Colors.grey,
                      height: 150,
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "Cerrar Sesión",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            flex: 1,
                          ),
                          Expanded(
                              flex: 3,
                              child: Text(
                                "¿Estás seguro que deseas cerrar sesión? Puedes iniciar tú sesión nuevamente cuando quieras.",
                                textAlign: TextAlign.center,
                              )),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                FlatButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("Cancelar"),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                ),
                                RaisedButton(
                                  onPressed: () {
                                    homeBloc.add(LogoutEvent());
                                  },
                                  color: Colors.deepPurpleAccent[700],
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Text(
                                    "Cerrar Sesión",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )));
              showDialog(context: context, child: alertDialog);
            },
          ),
        ],
      ),
    );
  }
}
