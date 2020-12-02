import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';

class SecurityPage extends StatefulWidget {
  @override
  _SecurityPageState createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  final NavigationService navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Seguridad",
          style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            leading: (Platform.isAndroid)
                ? Icon(Icons.lock)
                : Icon(CupertinoIcons.lock_fill),
            title: Text("Cambiar contraseña"),
            onTap: () {
              navigationService.navigateTo(Routes.ChangePasswordRoute);
            },
          )
        ],
      ),
    );
  }
}
