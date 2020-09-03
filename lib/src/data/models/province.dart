import 'package:pamiksa/src/data/models/municipality.dart';

class Province {
  String id;
  String name;
  List<dynamic> municipalities;

  Province({this.id, this.name, this.municipalities});

  String toString() {
    return 'Nombre: ${this.name}';
  }
}
