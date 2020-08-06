import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegisterForm extends StatefulWidget {
  @override
  RegisterFormState createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  String nombre;
  static int years = DateTime.now().year - 18;
  DateTime selectedDate =
      DateTime(years, DateTime.now().month, DateTime.now().day);

  _validateNombre(String value) {
    if (value.isEmpty) {
      return '¡Ingrese su nombre!';
    }
  }

  void _datePickerDialog(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: selectedDate);
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
//    String _formattedate = new DateFormat().add_yMMMMd().format(selectedDate);

    return Container(
      margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
      child: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          TextFormField(
            textCapitalization: TextCapitalization.words,
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
          InkWell(
            child: GestureDetector(
              child: InputDecorator(
                decoration: InputDecoration(
                    labelText: "Fecha de nacimiento*",
                    enabled: true,
                    icon: Icon(Icons.calendar_today)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                          "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
                      Icon(Icons.arrow_drop_down),
                    ]),
              ),
              onTap: () {
                _datePickerDialog(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
