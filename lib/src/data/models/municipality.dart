class MunicipalityModel {
  String id;
  String name;
  String provinceFk;

  MunicipalityModel({this.id, this.name, this.provinceFk});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'provinceFk': provinceFk
    };
    return map;
  }

  @override
  String toString() {
    return 'ID: ${this.id}, Nombre: ${this.name}, ProvinceFk: ${this.provinceFk}';
  }
}
