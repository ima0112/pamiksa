import 'package:flutter/material.dart';

class PolicyPage extends StatefulWidget {
  @override
  _PolicyPageState createState() => _PolicyPageState();
}

class _PolicyPageState extends State<PolicyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Politicas de Privacidad",
            style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1.color,
                fontWeight: FontWeight.bold)),
        elevation: 2.0,
      ),
    );
  }
}
