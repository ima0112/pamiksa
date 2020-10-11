import 'package:flutter/material.dart';

class BusinessDetailsItemPage extends StatefulWidget {
  @override
  _BusinessDetailsItemPageState createState() =>
      _BusinessDetailsItemPageState();
}

class _BusinessDetailsItemPageState extends State<BusinessDetailsItemPage> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      title: Text("Pizza"),
      subtitle: Text("Precio: 25"),
      trailing: Image.asset("assets/images/profile.png"),
      dense: true,
    );
  }
}
