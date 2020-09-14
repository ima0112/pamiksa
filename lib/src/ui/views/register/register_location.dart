import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/register_location/register_location_bloc.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';

class RegisterLocationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new RegisterLocationState();
}

class RegisterLocationState extends State<RegisterLocationPage> {
  final NavigationService navigationService = locator<NavigationService>();
  final _formKey = GlobalKey<FormState>();
  LocationBloc locationBloc;

  List<String> _provincias = ['Matanzas'];
  List<String> _municipios = ['Cárdenas'];

  String _selectedprovincia;
  String _selectedmunicipio;
  String adress;
  String provinceId;
  int municipalityId;

  _validateDireccion(String value) {
    if (value.isEmpty) {
      return '¡Ingrese su dirección!';
    }
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    locationBloc = BlocProvider.of<LocationBloc>(context);
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
        child: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            return Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Crear cuenta",
                      style: TextStyle(fontFamily: 'Roboto', fontSize: 30),
                    ),
                  ),
                  Flexible(
                    child: Form(
                      key: _formKey,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
                          child: Container(
                              margin:
                                  EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 16.0),
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
                                    onChanged: (dynamic value) {
                                      _selectedprovincia = value;
                                    },
                                    validator: (value) => value == null
                                        ? '¡Escoge tu provincia!'
                                        : null,
                                    items: _provincias.map((e) {
                                      return DropdownMenuItem(
                                        child: new Text(e),
                                        value: e,
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
                                    onChanged: (dynamic value) {
                                      _selectedmunicipio = value;
                                    },
                                    validator: (value) => value == null
                                        ? '¡Escoge tu municipio!'
                                        : null,
                                    items: _municipios.map((e) {
                                      return DropdownMenuItem(
                                        child: new Text(e),
                                        value: e,
                                      );
                                    }).toList(),
                                  ),
                                  TextFormField(
                                    initialValue: adress,
                                    textCapitalization:
                                        TextCapitalization.words,
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
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              width: 2)),
                                    ),
                                    onChanged: (String value) {
                                      adress = value;
                                    },
                                    validator: (value) =>
                                        _validateDireccion(value),
                                  ),
                                ],
                              )),
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
                            navigationService.goBack();
                          },
                          child: Text(
                            "ATRÁS",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
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
                              locationBloc.add(MutateCodeEvent(adress));
                            }
                          },
                          child: Text(
                            'SIGUIENTE',
                            style: TextStyle(fontFamily: 'RobotoMono-Regular'),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
