class MunicipalityModel {
  String id;
  String name;
  String provinceFk;

  MunicipalityModel({this.id, this.name, this.provinceFk});

  @override
  String toString() {
    return 'ID: ${this.id}, Nombre: ${this.name}, ProvinceFk: ${this.provinceFk}';
  }
}
