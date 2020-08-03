//class Register
//DropdownButton(
//isExpanded: true,
//elevation: 16,
//underline: Container(
//height: 1,
//color: Colors.black38,
//),
//hint: Text('Provincia*'),
//style: TextStyle(
//debugLabel: 'hola',
//fontFamily: 'RobotoMono-Regular',
//color: Colors.black54,
//fontSize: 16),
//value: _selectedprovincia,
//onChanged: (newValue) {
//setState(() {
//_selectedprovincia = newValue;
//});
//},
//items: _provincias.map((location) {
//return DropdownMenuItem(
//child: new Text(location),
//value: location,
//);
//}).toList(),
//),
//DropdownButton(
//isExpanded: true,
//underline: Container(
//height: 1,
//color: Colors.black38,
//),
//hint: Text('Municipio*'),
//style: TextStyle(
//fontFamily: 'RobotoMono-Regular',
//color: Colors.black54,
//fontSize: 16),
//value: _selectedmunicipio,
//onChanged: (newValue) {
//setState(() {
//_selectedmunicipio = newValue;
//});
//},
//items: _municipios.map((location) {
//return DropdownMenuItem(
//child: new Text(location),
//value: location,
//);
//}).toList(),
//),