class ProvinceModel {
  String id;
  String name;

  ProvinceModel({this.id, this.name});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
    };
    return map;
  }

  @override
  String toString() {
    return 'ID: ${this.id}, Nombre: ${this.name}';
  }
}
