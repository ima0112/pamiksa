import 'package:pamiksa/src/data/models/municipality.dart';

class ProvinceModel {
  String id;
  String name;
  List<MunicipalityModel> municipalities;

  ProvinceModel({this.id, this.name, this.municipalities});

  @override
  String toString() {
    return 'ID: ${this.id}, Nombre: ${this.name}, Municipalities: ${this.municipalities}';
  }
}
