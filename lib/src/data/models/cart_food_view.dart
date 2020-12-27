class CartFoodViewModel {
  String id;
  String name;
  double price;
  String photo;
  String photoUrl;
  int quantity;
  int availability;

  CartFoodViewModel({
    this.id,
    this.name,
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
      'photo': photo,
      'photoUrl': photoUrl,
      'price': price,
      'availability': availability,
      'quantity': quantity,
    };
    return map;
  }

  fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    name = map['name'];
    photo = map['photo'];
    photoUrl = map['photoUrl'];
    price = map['price'];
    quantity = map['quantity'];
    availability = map['availability'];
  }

  @override
  String toString() {
    return 'ID: ${this.id}, Photo: ${this.photo}, Price: ${this.price}, Name: ${this.name}, Availability: ${this.availability}';
  }
}
