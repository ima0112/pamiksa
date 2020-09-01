class Business {
  String id;
  String name;
  String description;
  String adress;
  String phone;
  String email;
  String photo;
  String businessOwnerFk;
  String provinceFk;
  String municipalityFk;
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
      this.provinceFk,
      this.valoration,
      this.municipalityFk});

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
      businessOwnerFk: json['businessOwnerFk'],
      provinceFk: json['provinceFk'],
      municipalityFk: json['municipalityFk'],
    );
  }

  @override
  String toString() {}
}
