import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pamiksa/src/data/graphql/graphqlConfig.dart';
import 'package:pamiksa/src/data/graphql/mutations/signUp.dart';
import 'package:pamiksa/src/data/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Text("usuario creado"),
    ));
  }
}
