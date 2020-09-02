import 'package:pamiksa/src/data/models/businessOwner.dart';

class Business {
  String id;
  String name;
  String description;
  String adress;
  String phone;
  String email;
  String photo;
  BusinessOwner businessOwnerFk;
  double deliveryPrice;
  double valoration;

  Business(
      {this.id,
      this.name,
      this.description,
      this.adress,
      this.phone,
      this.email,
      this.deliveryPrice,
      this.photo,
      this.businessOwnerFk,
      this.valoration,});

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      adress: json['adress'],
      phone: json['phone'],
      valoration: json['valoration'],
      email: json['email'],
      photo: json['photo'],
    );
  }

  @override
  String toString() {
    return 'Nombre: ${this.name}, ';
  }
}
