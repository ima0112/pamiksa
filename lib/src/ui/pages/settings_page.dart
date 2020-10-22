import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/blocs.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  RootBloc homeBloc;
  DevicesBloc devicesBloc;
  final NavigationService navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    homeBloc = BlocProvider.of<RootBloc>(context);
    devicesBloc = BlocProvider.of<DevicesBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ajustes",
          style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontWeight: FontWeight.bold),
        ),
        elevation: 2.0,
      ),
      body: WillPopScope(
        onWillPop: () async {
          navigationService.navigateWithoutGoBack(Routes.HomeRoute);
          return false;
        },
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text("Perfil"),
              onTap: () {
                navigationService.navigateTo(Routes.Profile);
              },
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
                navigationService.navigateTo(Routes.ThemeRoute);
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
                navigationService.navigateTo(Routes.HelpRoute);
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  FlatButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("Cancelar"),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                  ),
                                  RaisedButton(
                                    onPressed: () {
                                      homeBloc.add(LogoutEvent());
                                    },
                                    color: Colors.deepPurpleAccent[700],
                                    elevation: 0.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
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
      ),
    );
  }
}
