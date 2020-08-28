import 'package:shared_preferences/shared_preferences.dart';

class Shared {
  Future<String> read(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = prefs.getString(key);
    return data;
  }

  save(String key, value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  remove(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
