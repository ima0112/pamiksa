import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/blocs.dart';
import 'package:pamiksa/src/data/models/business.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';
import 'package:pamiksa/src/ui/pages/pages.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RootBloc homeBloc;
  MySearchDelegate _delegate;
  List<String> _list;
  int _currentIndex = 0;

  @override
  void initState() {
    createSearchResultList();
    _delegate =
        MySearchDelegate(words: _list, textInputType: TextInputType.text);
    super.initState();
  }

  void createSearchResultList() {
    _list = <String>[
      "Pizza",
      "Pan con jamon",
      "Pan con queso",
      "Spaghettis",
      "Pan con pasta",
      "Pan con croqueta",
      "Pan con hamburguesa",
    ];
  }

  List list = [RootPage(), null, FavoritePage(), SettingsPage()];

  @override
  Widget build(BuildContext context) {
    homeBloc = BlocProvider.of<RootBloc>(context);

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            backgroundColor: Theme.of(context).primaryColorLight,
            automaticallyImplyLeading: false,
            elevation: 0.0,
          )),
      body: list[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 12.0,
        selectedFontSize: 12.0,
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 1) {
            showSearch(
                context: context,
                delegate: MySearchDelegate(
                    words: _list, textInputType: TextInputType.text));
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted), title: Text("Inicio")),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), title: Text("Buscar")),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), title: Text("Favoritos")),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), title: Text("Ajustes")),
        ],
      ),
    );
  }
}
