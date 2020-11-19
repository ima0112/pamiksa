import 'package:flutter/material.dart';

class SearchDetailsPage extends StatefulWidget {
  @override
  _SearchDetailsPageState createState() => _SearchDetailsPageState();
}

class _SearchDetailsPageState extends State<SearchDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Detalles"),
        ),
        body: Center(
          child: Container(
            child: Text("Aqui van los detalles del resultado de la busqueda"),
          ),
        ));
  }
}
