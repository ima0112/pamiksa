import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'calendar.dart';

class RegisterForm extends StatefulWidget {
  @override
  RegisterFormState createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  String nombre;
  DateTime _selectedfecha;

  _validateNombre(String value) {
    if (value.isEmpty) {
      return '¡Ingrese su nombre!';
    }
  }

  void _datePickerDialog() {
    DateTime now = DateTime.now();
    showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(2000),
        lastDate: DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final cursorColor = Theme.of(context).primaryColor;

    return Container(
      margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
      child: Column(
        children: [
          SizedBox(height: 5,),
          TextFormField(
            textCapitalization: TextCapitalization.words,
            cursorColor: cursorColor,
            style: TextStyle(
                fontFamily: 'RobotoMono-Regular',
                color: Colors.black54,
                fontSize: 16),
            decoration: InputDecoration(
              helperText: "",
              icon: Icon(Icons.person),
              filled: false,
              fillColor: Colors.white24,
              labelText: "Nombre y Apellidos*",
              labelStyle: TextStyle(fontFamily: 'RobotoMono-Regular'),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 2)),
            ),
            onSaved: (value) {
              nombre = value;
            },
            validator: (value) => _validateNombre(value),
          ),
          SizedBox(
            height: 25,
          ),
          TextFormField(
            keyboardType: TextInputType.datetime,
            cursorColor: cursorColor,
            style: TextStyle(
                fontFamily: 'RobotoMono-Regular',
                color: Colors.black54,
                fontSize: 16),
            decoration: InputDecoration(
              helperText: "",
              icon: Icon(Icons.calendar_today),
              suffixIcon: GestureDetector(
                onTap: (){
                  _datePickerDialog;
                },
                  child: Icon(Icons.arrow_drop_down),
              ),
              filled: false,
              fillColor: Colors.white24,
              labelText: "Fecha de nacimiento*",
              labelStyle: TextStyle(fontFamily: 'RobotoMono-Regular'),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 2)),
            ),
            onSaved: (value) {
              nombre = value;
            },
            validator: (value) => _validateNombre(value),
          ),
//          LAWidget(),
        ],
      ),
    );
  }
}