import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/register_personal_info/register_personal_info_bloc.dart';
import 'package:pamiksa/src/data/storage/shared.dart';
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
  final _formKey = GlobalKey<FormState>();

  RegisterPersonalInfoBloc registerPersonalInfoBloc;
  String name;
  DateTime date;
  DateTime selectedDate;
  Shared preferences = Shared();
  int year;
  int month;
  int day;
  bool spinner = true;

  _validateNombre(String value) {
    if (value.isEmpty) {
      return '¡Ingrese su nombre!';
    }
  }

  Future<Null> _datePickerDialog(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      locale: const Locale("es", "CU"),
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(year, month, day),
    );
    if (picked != null)
      setState(() {
        selectedDate = picked;
      });
    print(selectedDate);
  }

  @override
  void initState() {
    getPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    registerPersonalInfoBloc =
        BlocProvider.of<RegisterPersonalInfoBloc>(context);
    return spinner
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            // resizeToAvoidBottomPadding: false,
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(0),
                child: AppBar(
                  elevation: 0.0,
                  backgroundColor: Color(0xffF5F5F5),
                  brightness: Brightness.light,
                )),
            body: Container(
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
                  Divider(
                    height: 0.0,
                  ),
                  downButtons()
                ],
              ),
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
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.center,
                child: TextFormField(
                  initialValue: name,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    helperText: "",
                    icon: Icon(Icons.person),
                    filled: false,
                    fillColor: Colors.white24,
                    labelText: "Nombre y Apellidos",
                    labelStyle: TextStyle(fontFamily: 'RobotoMono-Regular'),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 2)),
                  ),
                  validator: (value) => _validateNombre(value),
                  onChanged: (String value) {
                    name = value;
                  },
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.topCenter,
                child: InkWell(
                  child: GestureDetector(
                    child: InputDecorator(
                      decoration: InputDecoration(
                          labelText: "Fecha de nacimiento",
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget downButtons() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
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
                  registerPersonalInfoBloc.add(
                      SaveUserPersonalInfoEvent(name, selectedDate.toString()));
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
    );
  }

  void getPreferences() async {
    this.year = await preferences.read('year');
    this.month = await preferences.read('month');
    this.day = await preferences.read('day');
    setState(() {
      spinner = false;
      selectedDate = DateTime(year, month, day);
    });
  }
}
