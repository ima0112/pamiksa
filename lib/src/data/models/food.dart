class FoodModel {
  String id;
  String name;
  String description;
  double price;
  String photo;
  String photoUrl;
  int isAvailable;
  int availability;

  FoodModel(
      {this.id,
      this.availability,
      this.isAvailable,
      this.name,
      this.description,
      this.photo,
      this.photoUrl,
      this.price});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'availability': availability,
      'isAvailable': isAvailable,
      'photo': photo,
      'photoUrl': photoUrl,
      'price': price,
    };
    return map;
  }

  fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    name = map['name'];
    description = map['description'];
    availability = map['availability'];
    isAvailable = map['isAvailable'];
    photo = map['photo'];
    photoUrl = map['photoUrl'];
    price = map['price'];
  }

  @override
  String toString() {
    return 'ID: ${this.id}, Photo: ${this.photo}, Price: ${this.price}, Name: ${this.name}, Availability: ${this.availability}, IsAvailable: ${this.isAvailable}';
  }
}
