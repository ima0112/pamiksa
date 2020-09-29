import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/theme/theme_bloc.dart';
import 'package:pamiksa/src/data/storage/shared.dart';
import 'package:pamiksa/src/ui/themes/theme_manager.dart';

class ThemePage extends StatefulWidget {
  @override
  _ThemeState createState() => _ThemeState();
}

class _ThemeState extends State<ThemePage> {
  dynamic itemAppTheme;
  Shared preferences = Shared();

  ThemeBloc themeBloc;

  int value = 0;
  List themes = ['Predeterminado del sistema', 'Claro', 'Oscuro'];

  @override
  void initState() {
    getPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    themeBloc = BlocProvider.of<ThemeBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        bottom: PreferredSize(
            child: AppBar(
              title: Text(
                "Tema",
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color,
                    fontWeight: FontWeight.bold),
              ),
              elevation: 2.0,
            ),
            preferredSize: Size.fromHeight(0)),
      ),
      body: Column(
        children: [
          for (var i = 0; i < themes.length; i++)
            RadioListTile(
              value: i,
              groupValue: value,
              title: Text("${themes[i]}"),
              onChanged: (int val) {
                themeBloc.add(ChangedThemeEvent(val));
                setState(() {
                  value = val;
                });
              },
            ),
        ],
      ),
    );
  }

  void getPreferences() async {
    int lightMode = await preferences.read('themeMode');
    setState(() {
      value = lightMode;
    });
  }
}
