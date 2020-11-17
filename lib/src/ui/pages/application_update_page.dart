import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ApplicationUpdate extends StatefulWidget {
  @override
  _ApplicationUpdateState createState() => _ApplicationUpdateState();
}

class _ApplicationUpdateState extends State<ApplicationUpdate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Actualiza la aplicacion"),
      ),
    );
  }
}
