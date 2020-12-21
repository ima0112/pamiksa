import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

class ErrorPage extends StatefulWidget {
  final Equatable event;
  final Bloc bloc;

  const ErrorPage({Key key, this.event, this.bloc}) : super(key: key);

  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: FlatButton.icon(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                onPressed: () {
                  widget.bloc.add(widget.event);
                },
                icon: Icon(Icons.refresh),
                label: Text("Reintentar"))));
  }
}
