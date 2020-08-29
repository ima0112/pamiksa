import 'dart:io';
import 'dart:math';
import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pamiksa/src/data/graphql/graphqlConfig.dart';
import 'package:pamiksa/src/data/graphql/mutations/sendDeviceInfo.dart';
import 'package:pamiksa/src/data/graphql/mutations/sendVerificationCode.dart';
import 'package:pamiksa/src/data/graphql/mutations/signUp.dart';
import 'package:pamiksa/src/data/models/device.dart';
import 'package:pamiksa/src/data/models/user.dart';
import 'package:pamiksa/src/data/route.dart';
import 'package:pamiksa/src/data/shared/shared.dart';
import 'package:pamiksa/src/ui/views/register/verification.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterLocationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new RegisterLocationState();
}

class RegisterLocationState extends State<RegisterLocationPage> {
  final _formKey = GlobalKey<FormState>();
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  User user = User();
  Device device = Device();
  Ruta ruta = Ruta();
  Shared preferences = Shared();

  Map<String, dynamic> _deviceData = <String, dynamic>{};

  List<String> _provincias = ['Matanzas'];
  List<String> _municipios = ['Cárdenas'];
  String _selectedprovincia;
  String _selectedmunicipio;
  String direccion;
  String correo;
  int code;

  _validateDireccion(String value) {
    if (value.isEmpty) {
      return '¡Ingrese su dirección!';
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      obtenerPreferences();
    });
    return GraphQLProvider(
      client: GraphQLConfiguration.client,
      child: CacheProvider(
        child: Scaffold(
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
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
                          child: Container(
                            margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 16.0),
                            child: Column(
                              children: [
                                DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: "Provincia",
                                    labelStyle: TextStyle(
                                        fontFamily: 'RobotoMono-Regular'),
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
                                    labelStyle: TextStyle(
                                        fontFamily: 'RobotoMono-Regular'),
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
                                    labelStyle: TextStyle(
                                        fontFamily: 'RobotoMono-Regular'),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                Theme.of(context).primaryColor,
                                            width: 2)),
                                  ),
                                  onChanged: (String value) {
                                    setState(() {
                                      direccion = value;
                                    });
                                  },
                                  validator: (value) =>
                                      _validateDireccion(value),
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
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                        Mutation(
                          options: MutationOptions(
                              documentNode: gql(sendVerificationCode)),
                          builder:
                              (RunMutation runMutation, QueryResult result) {
                            return RaisedButton(
                              textColor: Colors.white,
                              color: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  Navigator.push(context,
                                      ruta.createRouter(VerificationPage()));
                                  randomCode();
                                  runMutation({'code': code, 'email': correo});
                                  print({code, correo});
                                }
                              },
                              child: Text(
                                'SIGUIENTE',
                                style:
                                    TextStyle(fontFamily: 'RobotoMono-Regular'),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  addData(int random) async {
    await preferences.save('adress', direccion);
    await preferences.save('code', random.toString());
  }

  void randomCode() async {
    int min = 100000;
    int max = 999999;
    var randomizer = new Random();
    code = min + randomizer.nextInt(max - min);
    addData(code);
  }

  void obtenerPreferences() async {
    correo = await preferences.read('email');
  }
}
