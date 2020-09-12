import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/register_location/register_location_bloc.dart';
import 'package:pamiksa/src/blocs/register_personal_info/register_personal_info_bloc.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
import 'package:pamiksa/src/ui/themes/theme_manager.dart';

class RegisterPersonalInfoPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => RegisterPersonalInfoPage());
  }

  @override
  State<StatefulWidget> createState() => new RegisterPersonalInfoPageState();
}

class RegisterPersonalInfoPageState extends State<RegisterPersonalInfoPage> {
  final NavigationService navigationService = locator<NavigationService>();
  RegisterPersonalInfoBloc registerPersonalInfoBloc;
  final _formKey = GlobalKey<FormState>();
  String name;

  _validateNombre(String value) {
    if (value.isEmpty) {
      return '¡Ingrese su nombre!';
    }
  }

  static int years = DateTime.now().year - 18;
  DateTime selectedDate =
      DateTime(years, DateTime.now().month, DateTime.now().day);

  Future<Null> _datePickerDialog(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      locale: const Locale("es", "CU"),
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(years, DateTime.now().month, DateTime.now().day),
    );
    if (picked != null)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    registerPersonalInfoBloc =
        BlocProvider.of<RegisterPersonalInfoBloc>(context);
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
            if (state is LoadingState) {
              return Center(child: CircularProgressIndicator());
            }
            return Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Crear cuenta",
                      style: TextStyle(fontFamily: 'Roboto', fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 16.0),
                      child: Form(
                        key: _formKey,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  initialValue: name,
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
                                    labelText: "Nombre y Apellidos",
                                    labelStyle: TextStyle(
                                        fontFamily: 'RobotoMono-Regular'),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                Theme.of(context).primaryColor,
                                            width: 2)),
                                  ),
                                  validator: (value) => _validateNombre(value),
                                  onChanged: (String value) {
                                    name = value;
                                  },
                                ),
                                InkWell(
                                  child: GestureDetector(
                                    child: InputDecorator(
                                      decoration: InputDecoration(
                                          labelText: "Fecha de nacimiento",
                                          enabled: true,
                                          icon: Icon(Icons.calendar_today)),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                              registerPersonalInfoBloc.add(
                                  SaveUserPersonalInfoEvent(
                                      name, selectedDate.toString()));
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
