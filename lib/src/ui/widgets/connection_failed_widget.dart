import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ConnectionFailedWidget extends StatefulWidget {
  final Equatable event;

  const ConnectionFailedWidget({Key key, this.event}) : super(key: key);

  @override
  _ConnectionFailedWidgetState createState() => _ConnectionFailedWidgetState();
}

class _ConnectionFailedWidgetState extends State<ConnectionFailedWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 12.5,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Text(
            "Parece que tienes problemas en la conexión. Compruébalo y prueba otra vez.",
            style: TextStyle(color: Colors.grey[700]),
            textAlign: TextAlign.center,
          ),
        ),
        FlatButton.icon(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            onPressed: () {},
            icon: Icon(Icons.refresh),
            label: Text("Reintentar"))
      ],
    );
  }
}
