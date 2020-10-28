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
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            backgroundColor: Theme.of(context).primaryColorLight,
            automaticallyImplyLeading: false,
            elevation: 0.0,
          )),
      body: Column(
        children: <Widget>[
          AppBar(
            title: Text(
              "Seguridad",
              style: TextStyle(
                  color:
                  Theme.of(context).textTheme.bodyText1.color,
                  fontWeight: FontWeight.bold),
            ),
            elevation: 2.0,
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text("Cambiar contraseña"),
            onTap: () {
              navigationService.navigateTo(Routes.ChangePassword);
            },
          )
        ],
      ),
    );
  }
}
