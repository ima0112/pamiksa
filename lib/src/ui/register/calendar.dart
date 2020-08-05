import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LAWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LAlertWidget();
  }
}

class LAlertWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    void _datePickerDialog() {
      DateTime now = DateTime.now();
      showDatePicker(
          context: context,
          initialDate: now,
          firstDate: DateTime(2000),
          lastDate: DateTime.now());
    }

    return RaisedButton(
      child: Text('Date Picker Dialog'),
      onPressed: _datePickerDialog,
    );
  }
}
