import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'file:///C:/Users/Imandra/AndroidStudioProjects/pamiksa/lib/src/models/consts.dart' show COLORPRIMARYLIGTH, REGISTRER_SMS;

class Register extends StatefulWidget {
  static const URI = '/register';

  @override
  FormRegisterState createState() => new FormRegisterState();

}

class FormRegisterState extends State<Register> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  List<String> _provincias = ['Matanzas', 'La Habana'];
  List<String> _municipios = ['Cárdenas'];
  String _selectedprovincia;
  String _selectedmunicipio;

  _validateNombre(String value) {
    if (value.isEmpty) {
      return '¡Ingrese su nombre!';
    }
  }

  _validateProvincia(String value) {
    if (value.isEmpty) {
      return '¡Ingrese una provincia!';
    }
  }

  _validateMunicipio(String value) {
    if (value.isEmpty) {
      return '¡Ingrese un municipio!';
    }
  }

  _validateDireccion(String value) {
    if (value.isEmpty) {
      return '¡Ingrese una dirección!';
    }
  }

  String _nombre;
  String _provincia;
  String _municipio;
  String _direccion;

  @override
  Widget build(BuildContext context) {
    final cursorColor = COLORPRIMARYLIGTH;
    const sizedBoxSpace = SizedBox(height: 24);
    const color = COLORPRIMARYLIGTH;

    return MaterialApp(
      theme: ThemeData(primaryColor: COLORPRIMARYLIGTH),
      home: Scaffold(
        body: Center(
          child: Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 16.0),
              padding: EdgeInsets.only(
                  top: 50.0, bottom: 0, right: 16.0, left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  sizedBoxSpace,
                  Text(
                    REGISTRER_SMS,
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                  TextFormField(
                    maxLength: 50,
                    textCapitalization: TextCapitalization.words,
                    cursorColor: cursorColor,
                    style: TextStyle(
                        fontFamily: 'RobotoMono-Regular',
                        color: Colors.black54,
                        fontSize: 16),
                    decoration: InputDecoration(
                      filled: false,
                      fillColor: Colors.white24,
                      labelText: "Nombre*",
                      labelStyle: TextStyle(fontFamily: 'RobotoMono-Regular'),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: color, width: 2)),
                    ),
                    onSaved: (value) {
                      _nombre = value;
                    },
                    validator: (value) => _validateNombre(value),
                  ),
                  DropdownButton(
                    isExpanded: true,
                    elevation: 16,
                    underline: Container(
                      height: 1,
                      color: Colors.black38,
                    ),
                    hint: Text('Provincia*'),
                    style: TextStyle(
                      debugLabel: 'hola',
                        fontFamily: 'RobotoMono-Regular',
                        color: Colors.black54,
                        fontSize: 16),
                    value: _selectedprovincia,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedprovincia = newValue;
                      });
                    },
                    items: _provincias.map((location) {
                      return DropdownMenuItem(
                        child: new Text(location),
                        value: location,
                      );
                    }).toList(),
                  ),
                  DropdownButton(
                    isExpanded: true,
                    underline: Container(
                      height: 1,
                      color: Colors.black38,
                    ),
                    hint: Text('Municipio*'),
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
                    items: _municipios.map((location) {
                      return DropdownMenuItem(
                        child: new Text(location),
                        value: location,
                      );
                    }).toList(),
                  ),
                  TextFormField(
                    maxLength: 150,
                    textCapitalization: TextCapitalization.words,
                    cursorColor: cursorColor,
                    style: TextStyle(
                        fontFamily: 'RobotoMono-Regular',
                        color: Colors.black54,
                        fontSize: 16),
                    decoration: InputDecoration(
                      filled: false,
                      fillColor: Colors.white24,
                      labelText: "Dirección*",
                      labelStyle: TextStyle(fontFamily: 'RobotoMono-Regular'),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: color, width: 2)),
                    ),
                    onSaved: (value) {
                      _direccion = value;
                    },
                    validator: (value) => _validateDireccion(value),
                  ),
                  sizedBoxSpace,
                  Container(
                    height: 45,
                    width: 320,
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          // Si el formulario es válido, queremos mostrar un Snackbar
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text('Processing Data')));
                        }
                      },
                      child: Text(
                        'REGISTRARME',
                        style: TextStyle(
                            fontFamily: 'RobotoMono-Regular',
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                  sizedBoxSpace,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
