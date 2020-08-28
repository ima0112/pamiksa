class User {
  String id;
  String fullName;
  String adress;
  String birthday;
  String email;
  String password;
  String photo;

  User(
      {this.id,
      this.fullName,
      this.adress,
      this.birthday,
      this.email,
      this.password,
      this.photo});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        fullName: json['fullName'],
        adress: json['adress'],
        birthday: json['birthday'],
        email: json['email'],
        password: json['password'],
        photo: json['photo']);
  }
}
