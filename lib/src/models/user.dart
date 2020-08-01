class User {
  String fullName;
  String userId;
  String telephone;
  String phone;
  String ci;
  String email;
  String address;
  String businessUserProvincia;
  String businessUserMunicipio;

  User(
      {this.fullName,
      this.userId,
      this.telephone,
      this.phone,
      this.ci,
      this.email,
      this.address,
      this.businessUserProvincia,
      this.businessUserMunicipio});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullName: json['fullName'],
      userId: json['userId'],
      telephone: json['telephone'],
      phone: json['phone'],
      ci: json['ci'],
      email: json['email'],
      address: json['address'],
      businessUserProvincia: json['businessUserProvincia'],
      businessUserMunicipio: json['businessUserMunicipio'],
    );
  }
}
