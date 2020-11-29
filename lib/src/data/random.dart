import 'dart:math';

Future<int> randomCode() async {
  int min = 100000;
  int max = 999999;
  var randomize = new Random();
  int code = min + randomize.nextInt(max - min);
  return code;
}
