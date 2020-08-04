import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pamiksa/src/ui/register/register_data.dart';

class RegisterLocationForm extends StatefulWidget{
  @override
  RegisterLocationFormState createState() => RegisterLocationFormState();
}

class RegisterLocationFormState extends State<RegisterLocationForm> {
  final _formKey = GlobalKey<FormState>();

  List<String> _provincias = ['Matanzas'];
  List<String> _municipios = ['Cárdenas'];
  String _selectedprovincia;
  String _selectedmunicipio;

  @override
  Widget build(BuildContext context) {
    const sizedBoxSpace = SizedBox(height: 50);

   return Form(
     key: _formKey,
     child: Container(
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           sizedBoxSpace,
           Container(
             padding: EdgeInsets.only(top: 50),
             child: Text(
               "Crear cuenta",
               style: TextStyle(fontFamily: 'Roboto', fontSize: 30),
               textAlign: TextAlign.center,
             ),
           ),
           SizedBox(height: 112,),
           Container(
             height: 470,
             margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
             padding: EdgeInsets.only(
                 top: 0, bottom: 0, right: 16.0, left: 16.0),
             child: Column(
               children: <Widget>[
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
                 SizedBox(height: 25,),
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
           ),
           Divider(),
           SizedBox(height: 2,),
           Container(
//              color: Colors.amber,
             alignment: Alignment.bottomCenter,
             margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 16.0),
             padding: EdgeInsets.only(
                 top: 0.0, bottom: 0.0, right: 16.0, left: 16.0),
             child: Row(
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
                     style:
                     TextStyle(color: Theme.of(context).primaryColor),
                   ),
                 ),
                 SizedBox(
                   width: 130,
                 ),
                 RaisedButton(
                   textColor: Colors.white,
                   color: Theme.of(context).primaryColor,
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(25),
                   ),
                   onPressed: () {
                     if (_formKey.currentState.validate()) {
//                          Navigator.of(context).push(_createRouter());
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
   );
  }

}