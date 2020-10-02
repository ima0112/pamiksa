import 'package:flutter/material.dart';

class ConditionsPage extends StatefulWidget {
  @override
  _ConditionsPageState createState() => _ConditionsPageState();
}

class _ConditionsPageState extends State<ConditionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        bottom: PreferredSize(
            child: AppBar(
              title: Text("Condiciones de Uso",
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1.color,
                      fontWeight: FontWeight.bold)),
              elevation: 2.0,
            ),
            preferredSize: Size.fromHeight(0)),
      ),
    );
  }
}
