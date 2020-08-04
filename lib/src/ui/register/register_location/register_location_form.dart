import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterLocationForm extends StatefulWidget {
  @override
  RegisterLocationFormState createState() => RegisterLocationFormState();
}

class RegisterLocationFormState extends State<RegisterLocationForm> {

  List<String> _provincias = ['Matanzas'];
  List<String> _municipios = ['Cárdenas'];
  String _selectedprovincia;
  String _selectedmunicipio;

  @override
  Widget build(BuildContext context) {

    return Container(
        margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
        child: Column(
          children: [
            SizedBox(height: 16,),
            DropdownButtonFormField(
              decoration: InputDecoration(
                helperText: "",
              ),
              hint: Text('Provincia*'),
              style: TextStyle(
                  fontFamily: 'RobotoMono-Regular',
                  color: Colors.black54,
                  fontSize: 16),
              value: _selectedprovincia,
              onChanged: (newValue) {
                setState(() {
                  _selectedprovincia = newValue;
                });
              },
              validator: (value) =>
              value == null ? '¡Escoge tu provincia!' : null,
              items: _provincias.map((location) {
                return DropdownMenuItem(
                  child: new Text(location),
                  value: location,
                );
              }).toList(),
            ),
            SizedBox(
              height: 36,
            ),
            DropdownButtonFormField(
              hint: Text('Municipio*'),
              decoration: InputDecoration(
                helperText: "",
              ),
              style: TextStyle(
                  fontFamily: 'RobotoMono-Regular',
                  color: Colors.black54,
                  fontSize: 16),
              value: _selectedmunicipio,
              onChanged: (newValue) {
                setState(() {
                  _selectedmunicipio = newValue;
                });
              },
              validator: (value) =>
              value == null ? '¡Escoge tu municipio!' : null,
              items: _municipios.map((location) {
                return DropdownMenuItem(
                  child: new Text(location),
                  value: location,
                );
              }).toList(),
            ),
          ],
        ),
    );
  }
}
