class User {
  String fullName;
  String adress;
  String birthday;
  String email;
  String password;
  String photo;

  User(
      {this.fullName,
      this.adress,
      this.birthday,
      this.email,
      this.password,
      this.photo});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        fullName: json['fullName'],
        adress: json['adress'],
        birthday: json['birthday'],
        email: json['email'],
        password: json['password'],
        photo: json['photo']);
  }
}
