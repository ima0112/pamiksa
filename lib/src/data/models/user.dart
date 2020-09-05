class UserModel {
  String id;
  String fullName;
  String adress;
  String birthday;
  String email;
  String photo;
  String password;
  String provinceFk;
  String municipalityFk;

  UserModel(
      {this.id,
      this.fullName,
      this.adress,
      this.birthday,
      this.email,
      this.photo,
      this.password,
      this.provinceFk,
      this.municipalityFk});

  @override
  String toString() {
    return 'ID: ${this.id}, Nombre: ${this.fullName}, Password: ${this.password}, Adress: ${this.adress}, Birthday: ${this.birthday}, Email: ${this.email}, Photo: ${this.photo}, ProvinceFk: ${this.provinceFk}, MunicipalityFk: ${this.municipalityFk}';
  }
}
