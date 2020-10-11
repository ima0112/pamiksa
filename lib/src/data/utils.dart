import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/blocs.dart';
import 'package:pamiksa/src/data/storage/shared.dart';

class Utils {
  Shared preferences = Shared();

  Future<bool> showIntro() async {
    final showIntro = await preferences.read('showIntro');

    if (showIntro != false) {
      return true;
    } else {
      return false;
    }
  }

  void mode() {
    ThemeBloc themeBloc;
    themeBloc.add(LoadedThemeEvent());
  }
}
