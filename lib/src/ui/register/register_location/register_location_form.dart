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
  String direccion;

  _validateDireccion(String value) {
    if (value.isEmpty) {
      return '¡Ingrese su dirección!';
    }
  }

  @override
  Widget build(BuildContext context) {

    return Container(
        margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
        child: Column(
          children: [
            DropdownButtonFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: "Provincia*",
                labelStyle: TextStyle(fontFamily: 'RobotoMono-Regular'),
                icon: Icon(Icons.location_city),
                helperText: "",
              ),
//              hint: Text('Provincia*'),
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
              height: 20,
            ),
            DropdownButtonFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: "Municipio*",
                labelStyle: TextStyle(fontFamily: 'RobotoMono-Regular'),
                icon: Icon(Icons.near_me),
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
            SizedBox(
              height: 25,
            ),
            TextFormField(
              textCapitalization: TextCapitalization.words,
              style: TextStyle(
                  fontFamily: 'RobotoMono-Regular',
                  color: Colors.black54,
                  fontSize: 16),
              decoration: InputDecoration(
                helperText: "",
                icon: Icon(Icons.location_on),
                filled: false,
                fillColor: Colors.white24,
                labelText: "Dirección*",
                labelStyle: TextStyle(fontFamily: 'RobotoMono-Regular'),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 2)),
              ),
              onSaved: (value) {
                direccion = value;
              },
              validator: (value) => _validateDireccion(value),
            ),
          ],
        ),
    );
  }
}
