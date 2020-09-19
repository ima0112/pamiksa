import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  read(String key) async {
    final storage = new FlutterSecureStorage();
    return await storage.read(key: key);
  }

  readAll(String key) async {
    final storage = new FlutterSecureStorage();
    return await storage.readAll();
  }

  save(String key, value) async {
    final storage = new FlutterSecureStorage();
    await storage.write(key: key, value: value);
  }

  remove(String key) async {
    final storage = new FlutterSecureStorage();
    await storage.delete(key: key);
  }

  removeAll(String key) async {
    final storage = new FlutterSecureStorage();
    await storage.deleteAll();
  }
}
