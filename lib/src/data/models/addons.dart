class AddonsModel {
  String id;
  String name;
  double price;

  AddonsModel({this.id, this.name, this.price});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
    };
    return map;
  }

  fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    name = map['name'];
    price = map['price'];
  }

  @override
  String toString() {
    return 'ID: ${this.id}, Price: ${this.price}, Name: ${this.name}';
  }
}
