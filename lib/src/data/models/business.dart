class BusinessModel {
  String id;
  String name;
  String description;
  String adress;
  String phone;
  String email;
  String photo;
  String photoUrl;
  double deliveryPrice;
  double valoration;
  int valorationsQuantity;
  double valorationSum;

  BusinessModel(
      {this.id,
      this.name,
      this.description,
      this.adress,
      this.phone,
      this.email,
      this.deliveryPrice,
      this.photo,
      this.photoUrl,
      this.valoration,
      this.valorationsQuantity,
      this.valorationSum});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'adress': adress,
      'phone': phone,
      'email': email,
      'deliveryPrice': deliveryPrice,
      'photo': photo,
      'photoUrl': photoUrl,
      'valoration': valoration,
      'valorationSum': valorationSum,
      'valorationsQuantity': valorationsQuantity
    };
    return map;
  }

  fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    name = map['name'];
    description = map['description'];
    adress = map['adress'];
    phone = map['phone'];
    email = map['email'];
    deliveryPrice = map['deliveryPrice'].toDouble();
    photo = map['photo'];
    photoUrl = map['photoUrl'];
    valoration = map['valoration'];
    valorationSum = map['valorationSum'];
    valorationsQuantity = map['valorationsQuantity'];
  }

  @override
  String toString() {
    return 'Id: ${this.id}, Nombre: ${this.name}, Description: ${this.description}, Adress: ${this.adress}, Phone: ${this.phone}, Email: ${this.email}, DeliveryPrice: ${this.deliveryPrice}, Photo: ${this.photo}, Valoration: ${this.valoration}';
  }
}
