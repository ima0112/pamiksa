import 'package:pamiksa/src/data/models/business_owner.dart';

class BusinessModel {
  String id;
  String name;
  String description;
  String adress;
  String phone;
  String email;
  String photo;
  BusinessOwnersModel businessOwner;
  double deliveryPrice;
  double valoration;

  BusinessModel({
    this.id,
    this.name,
    this.description,
    this.adress,
    this.phone,
    this.email,
    this.deliveryPrice,
    this.photo,
    this.businessOwner,
    this.valoration,
  });

  @override
  String toString() {
    return 'Id: ${this.id}, Nombre: ${this.name}, Description: ${this.description}, Adress: ${this.adress}, Phone: ${this.phone}, Email: ${this.email}, DeliveryPrice: ${this.deliveryPrice}, Photo: ${this.photo}, BusinessOwner{id: ${this.businessOwner.id}, ci: ${this.businessOwner.ci}, Valoration: ${this.valoration}';
  }
}
