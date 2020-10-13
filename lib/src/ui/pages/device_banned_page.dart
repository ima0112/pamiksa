import 'package:flutter/material.dart';

class DeviceBannedpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
        child: Center(
          child: Wrap(
            children: [
              Text(
                "Su dispositivo ha sido banneado. Por favor contactenos. Sentimos las molestias.",
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
