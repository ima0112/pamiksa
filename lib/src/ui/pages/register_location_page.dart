import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/register_location/register_location_bloc.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
import 'package:pamiksa/src/ui/pages/pages.dart';

class RegisterLocationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new RegisterLocationPageState();
}

class RegisterLocationPageState extends State<RegisterLocationPage> {
  final NavigationService navigationService = locator<NavigationService>();
  final _formKey = GlobalKey<FormState>();

  LocationBloc locationBloc;

  String selectedprovincia;
  String selectedmunicipio;
  String adress;
  // String provinceId;
  // int municipalityId;

  _validateDireccion(String value) {
    if (value.isEmpty) {
      return '¡Ingrese su dirección!';
    }
  }

  void initState() {
    locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.add(FetchProvinceMunicipalityDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          if (state is LoadingProvinceMunicipalityState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LocationInitial) {
            return Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: FittedBox(
                          child: Text(
                            "Crear cuenta",
                            style:
                                TextStyle(fontFamily: 'Roboto', fontSize: 30),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: form(),
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
                              locationBloc.add(LocationMutateCodeEvent(
                                  adress: adress,
                                  municipalityId: selectedmunicipio,
                                  provinceId: selectedprovincia));
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
          } else if (state is ErrorLocationState) {
            return ErrorPage(
              bloc: locationBloc,
              event: state.event,
            );
          }
          return ErrorPage(
            bloc: locationBloc,
            event: SetInitialLocationEvent(),
          );
        },
      ),
    );
  }

  Widget form() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 0.0),
        child: Column(
          children: [
            Expanded(flex: 1, child: provinces()),
            Expanded(flex: 1, child: municipalities()),
            Expanded(
              flex: 1,
              child: TextFormField(
                initialValue: adress,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  helperText: "",
                  icon: Icon(Icons.location_on),
                  filled: false,
                  fillColor: Colors.white24,
                  labelText: "Dirección",
                  labelStyle: TextStyle(fontFamily: 'RobotoMono-Regular'),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 2)),
                ),
                onChanged: (String value) {
                  adress = value;
                },
                validator: (value) => _validateDireccion(value),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget provinces() {
    return BlocBuilder<LocationBloc, LocationState>(builder: (context, state) {
      if (state is LoadedProvinceMunicipalityState) {
        return DropdownButtonFormField(
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            labelText: "Provincia",
            labelStyle: TextStyle(fontFamily: 'RobotoMono-Regular'),
            icon: Icon(
              Icons.location_city,
            ),
            helperText: "",
          ),
          onChanged: (dynamic value) {
            if (selectedprovincia != value) {
              selectedprovincia = value;
              locationBloc.add(ProvinceSelectedEvent(value));
            }
          },
          validator: (value) => value == null ? '¡Escoge tu provincia!' : null,
          items: state.results.map((e) {
            return DropdownMenuItem(
              child: new Text(e.name),
              value: e.id,
            );
          }).toList(),
        );
      } else if (state is MunicipalitiesLoadedState) {
        return DropdownButtonFormField(
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            labelText: "Provincia",
            labelStyle: TextStyle(fontFamily: 'RobotoMono-Regular'),
            icon: Icon(Icons.location_city),
            helperText: "",
          ),
          onChanged: (dynamic value) {
            if (selectedprovincia != value) {
              selectedprovincia = value;
              locationBloc.add(ProvinceSelectedEvent(value));
            }
          },
          validator: (value) => value == null ? '¡Escoge tu provincia!' : null,
          items: state.provincesResults.map((e) {
            return DropdownMenuItem(
              child: new Text(e.name),
              value: e.id,
            );
          }).toList(),
        );
      }
      return Container();
    });
  }

  Widget municipalities() {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        if (state is MunicipalitiesLoadedState) {
          return DropdownButtonFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: "Municipio",
              labelStyle: TextStyle(fontFamily: 'RobotoMono-Regular'),
              icon: Icon(Icons.location_city),
              helperText: "",
            ),
            onChanged: (dynamic value) {
              selectedmunicipio = value;
            },
            validator: (value) =>
                value == null ? '¡Escoge tu municipio!' : null,
            items: state.results.map((e) {
              return DropdownMenuItem(
                child: new Text(e.name),
                value: e.id,
              );
            }).toList(),
          );
        }
        return DropdownButtonFormField(
          items: [null],
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            labelText: "Municipio",
            labelStyle: TextStyle(fontFamily: 'RobotoMono-Regular'),
            icon: Icon(Icons.location_city),
            helperText: "",
          ),
          onChanged: (dynamic value) {
            return null;
          },
          validator: (value) => value == null ? '¡Escoge tu municipio!' : null,
        );
      },
    );
  }
}
