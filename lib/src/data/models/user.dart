import 'package:pamiksa/src/data/storage/secure_storage.dart';

class UserModel {
  SecureStorage secureStorage = SecureStorage();

  String id;
  String fullName;
  String adress;
  String birthday;
  String email;
  String photo;
  String password;
  String province;
  String municipality;

  UserModel(
      {this.id,
      this.fullName,
      this.adress,
      this.birthday,
      this.email,
      this.photo,
      this.password,
      this.province,
      this.municipality});

  Future<bool> isLoggedIn() async {
    final token = await secureStorage.read('authToken') ?? null;

    if (token != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  String toString() {
    return 'ID: ${this.id}, Nombre: ${this.fullName}, Password: ${this.password}, Adress: ${this.adress}, Birthday: ${this.birthday}, Email: ${this.email}, Photo: ${this.photo}, ProvinceFk: ${this.province}, MunicipalityFk: ${this.municipality}';
  }
}
