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

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'adress': adress,
      'email': email,
      'photo': photo,
    };
    return map;
  }

  fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    fullName = map['fullName'];
    adress = map['adress'];
    email = map['email'];
    photo = map['photo'];
  }

  @override
  String toString() {
    return 'ID: ${this.id}, Nombre: ${this.fullName}, Password: ${this.password}, Adress: ${this.adress}, Birthday: ${this.birthday}, Email: ${this.email}, Photo: ${this.photo}, ProvinceFk: ${this.province}, MunicipalityFk: ${this.municipality}';
  }
}
