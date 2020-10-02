import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/devices/devices_bloc.dart';
import 'package:pamiksa/src/blocs/home/home_bloc.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
import 'package:pamiksa/src/ui/navigation/route_paths.dart' as routes;

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  HomeBloc homeBloc;
  DevicesBloc devicesBloc;
  final NavigationService navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    homeBloc = BlocProvider.of<HomeBloc>(context);
    devicesBloc = BlocProvider.of<DevicesBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Configuración",
          style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontWeight: FontWeight.bold),
        ),
        elevation: 1.0,
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text("Cuenta"),
            onTap: () {},
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 15.0,
            ),
          ),
          ListTile(
            leading: Icon(Icons.credit_card),
            title: Text("Pedidos"),
            onTap: () {},
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 15.0,
            ),
          ),
          ListTile(
            leading: Icon(Icons.palette),
            title: Text("Tema"),
            onTap: () {
              navigationService.navigateTo(routes.ThemeRoute);
            },
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 15.0,
            ),
          ),
          ListTile(
            leading: Icon(Icons.devices),
            title: Text("Dispositivos"),
            onTap: () {
              devicesBloc.add(SetDeviceInitialEvent());
              homeBloc.add(ShowedDevicesEvent());
            },
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15.0,
            ),
          ),
          ListTile(
            leading: Icon(Icons.help_outline),
            title: Text("Ayuda"),
            onTap: () {
              navigationService.navigateTo(routes.HelpRoute);
            },
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 15.0,
            ),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text("Cerrar sesión"),
            onTap: () {
              AlertDialog alertDialog = AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  content: Container(
                      height: 150,
                      child: Column(
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
