import 'dart:math';

Future<int> randomCode() async {
  int min = 100000;
  int max = 999999;
  var randomizer = new Random();
  int code = min + randomizer.nextInt(max - min);
  return code;
}
