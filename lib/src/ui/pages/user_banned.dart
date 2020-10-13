import 'package:flutter/material.dart';

class UserBannedpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
        child: Center(
          child: Wrap(
            children: [
              Text(
                "Su usuario ha sido banneado. Por favor contactenos. Sentimos las molestias.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
