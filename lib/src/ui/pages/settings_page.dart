import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/blocs.dart';
import 'package:pamiksa/src/blocs/profile/profile_bloc.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  RootBloc rootBloc;
  DevicesBloc devicesBloc;
  ProfileBloc profileBloc;
  final NavigationService navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    rootBloc = BlocProvider.of<RootBloc>(context);
    devicesBloc = BlocProvider.of<DevicesBloc>(context);
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ajustes",
          style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          navigationService.navigateWithoutGoBack(Routes.HomeRoute);
          return false;
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: (Platform.isAndroid)
                    ? Icon(Icons.account_circle)
                    : Icon(CupertinoIcons.person),
                title: Text("Perfil"),
                onTap: () {
                  profileBloc.add(FetchProfileEvent());
                  navigationService.navigateTo(Routes.Profile);
                },
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 15.0,
                ),
              ),
              ListTile(
                leading: (Platform.isAndroid)
                    ? Icon(Icons.credit_card)
                    : Icon(CupertinoIcons.car_detailed),
                title: Text("Pedidos"),
                onTap: () {},
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 15.0,
                ),
              ),
              ListTile(
                leading: (Platform.isAndroid)
                    ? Icon(Icons.palette)
                    : Icon(CupertinoIcons.clear_thick),
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
                leading: (Platform.isAndroid)
                    ? Icon(Icons.security)
                    : Icon(CupertinoIcons.add),
                title: Text("Seguridad"),
                onTap: () {
                  navigationService.navigateTo(Routes.SecurityRoute);
                },
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 15.0,
                ),
              ),
              ListTile(
                leading: (Platform.isAndroid)
                    ? Icon(Icons.devices)
                    : Icon(CupertinoIcons.phone),
                title: Text("Dispositivos"),
                onTap: () {
                  devicesBloc.add(FetchDevicesDataEvent());
                  navigationService.navigateTo(Routes.DevicesRoute);
                },
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15.0,
                ),
              ),
              ListTile(
                leading: (Platform.isAndroid)
                    ? Icon(Icons.help_outline)
                    : Icon(CupertinoIcons.add),
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
                leading: (Platform.isAndroid)
                    ? Icon(Icons.input)
                    : Icon(CupertinoIcons.search),
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
                                        rootBloc.add(LogoutEvent());
                                      },
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
      ),
    );
  }
}
