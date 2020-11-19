class SuggestionsModel {
  String name;

  SuggestionsModel({this.name});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': name,
    };
    return map;
  }

  fromMap(Map<dynamic, dynamic> map) {
    name = map['name'];
  }

  @override
  String toString() {
    return 'Name: ${this.name}';
  }
}
