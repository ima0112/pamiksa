class CartFoodModel {
  String id;
  String name;
  String description;
  String foodFk;
  double price;
  String photo;
  String photoUrl;
  int quantity;
  int availability;

  CartFoodModel({
    this.id,
    this.name,
    this.description,
    this.foodFk,
    this.photo,
    this.photoUrl,
    this.price,
    this.quantity,
    this.availability,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'photo': photo,
      'photoUrl': photoUrl,
      'price': price,
      'foodFk': foodFk,
      'availability': availability,
      'quantity': quantity,
    };
    return map;
  }

  fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    name = map['name'];
    description = map['description'];
    photo = map['photo'];
    photoUrl = map['photoUrl'];
    price = map['price'];
    foodFk = map['foodFk'];
    quantity = map['quantity'];
    availability = map['availability'];
  }

  @override
  String toString() {
    return 'ID: ${this.id}, Photo: ${this.photo}, Price: ${this.price}, Name: ${this.name}, Availability: ${this.availability}';
  }
}
