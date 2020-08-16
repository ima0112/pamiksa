import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:pamiksa/src/ui/register/register_location/register_location_form.dart';
import 'package:pamiksa/src/ui/register/verification.dart';

class RegisterLocationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return RegisterLocation();
  }
}

class RegisterLocation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new RegisterLocationState();
}

class RegisterLocationState extends State<RegisterLocation> {
  final _formKey = GlobalKey<FormState>();
  final _dirCtrl = TextEditingController();
  Map data;

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
    data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Color(0xffF5F5F5),
            brightness: Brightness.light,
          )),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 5.0),
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                child: Text(
                  "Crear cuenta",
                  style: TextStyle(fontFamily: 'Roboto', fontSize: 30),
                ),
              ),
              Expanded(
                flex: 3,
                child: Form(
                  key: _formKey,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
                      child: Container(
                        margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 16.0),
                        child: Column(
                          children: [
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: "Provincia",
                                labelStyle:
                                    TextStyle(fontFamily: 'RobotoMono-Regular'),
                                icon: Icon(Icons.location_city),
                                helperText: "",
                              ),
                              style: TextStyle(
                                  fontFamily: 'RobotoMono-Regular',
                                  color: Colors.black54,
                                  fontSize: 16),
                              value: _selectedprovincia,
                              onChanged: (String value) {
                                setState(() {
                                  _selectedprovincia = value;
                                });
                              },
                              validator: (value) => value == null
                                  ? '¡Escoge tu provincia!'
                                  : null,
                              items: _provincias.map((location) {
                                return DropdownMenuItem(
                                  child: new Text(location),
                                  value: location,
                                );
                              }).toList(),
                            ),
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: "Municipio",
                                labelStyle:
                                    TextStyle(fontFamily: 'RobotoMono-Regular'),
                                icon: Icon(Icons.near_me),
                                helperText: "",
                              ),
                              style: TextStyle(
                                  fontFamily: 'RobotoMono-Regular',
                                  color: Colors.black54,
                                  fontSize: 16),
                              value: _selectedmunicipio,
                              onChanged: (String value) {
                                setState(() {
                                  _selectedmunicipio = value;
                                });
                              },
                              validator: (value) => value == null
                                  ? '¡Escoge tu municipio!'
                                  : null,
                              items: _municipios.map((location) {
                                return DropdownMenuItem(
                                  child: new Text(location),
                                  value: location,
                                );
                              }).toList(),
                            ),
                            TextFormField(
                              controller: _dirCtrl,
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
                                labelText: "Dirección",
                                labelStyle:
                                    TextStyle(fontFamily: 'RobotoMono-Regular'),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 2)),
                              ),
                              onChanged: (String value) {
                                setState(() {
                                  direccion = value;
                                });
                              },
                              validator: (value) => _validateDireccion(value),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Divider(),
              Container(
                margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                padding: EdgeInsets.only(
                    top: 0.0, bottom: 0.0, right: 16.0, left: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "ATRÁS",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    RaisedButton(
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          Navigator.pushNamed(context, "/verificar",
                              arguments: {
                                'email': data['email'],
                                'password': data['password'],
                                'name': data['name'],
                                'birthday': data['birthday'],
                                'adress': "${_dirCtrl.text}"
                              });
                        }
                      },
                      child: Text(
                        'SIGUIENTE',
                        style: TextStyle(fontFamily: 'RobotoMono-Regular'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Route _createRouter() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          VerificationPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(50.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      });
}
