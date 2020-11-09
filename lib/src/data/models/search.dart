class SearchModel {
  String id;
  String name;

  SearchModel({this.id, this.name});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
    };
    return map;
  }

  fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    name = map['name'];
  }

  @override
  String toString() {
    return 'ID: ${this.id}, Name: ${this.name}';
  }
}
