import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class Aleatorio {
  randomCode() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int min = 100000;
    int max = 999999;
    var randomizer = new Random();
    int code = min + randomizer.nextInt(max - min);
    preferences.setString('code', code.toString());
  }
}
