class FavoriteModel {
  String id;
  String name;
  double price;
  String photo;
  bool isAvailable;
  int availability;

  FavoriteModel(
      {this.id,
      this.availability,
      this.isAvailable,
      this.name,
      this.photo,
      this.price});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'availability': availability,
      'isAvailable': isAvailable,
      'photo': photo,
      'price': price,
    };
    return map;
  }

  fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    name = map['name'];
    availability = map['availability'];
    isAvailable = map['isAvailable'];
    photo = map['photo'];
    price = map['price'];
  }

  @override
  String toString() {
    return 'ID: ${this.id}, Photo: ${this.photo}, Price: ${this.price}, Name: ${this.name}, Availability: ${this.availability}, IsAvailable: ${this.isAvailable}';
  }
}
