class SuggestionsModel {
  int id;
  String name;

  SuggestionsModel({this.id, this.name});

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
    return 'Id: ${this.id}, Name: ${this.name}';
  }
}
