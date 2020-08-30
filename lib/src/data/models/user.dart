class User {
  String id;
  String fullName;
  String adress;
  String birthday;
  String email;
  String photo;
  String password;

  User(
      {this.id,
      this.fullName,
      this.adress,
      this.birthday,
      this.email,
      this.photo,
      this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        fullName: json['fullName'],
        adress: json['adress'],
        birthday: json['birthday'],
        email: json['email'],
        photo: json['photo']);
  }
}
