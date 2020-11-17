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
  List<String> _list;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  List list = [RootPage(), null, FavoritePage(), CartPage(), SettingsPage()];

  @override
  Widget build(BuildContext context) {
    homeBloc = BlocProvider.of<RootBloc>(context);

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
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
            showSearch(context: context, delegate: FoodSearch());
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text("Inicio")),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), title: Text("Buscar")),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), title: Text("Favoritos")),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), title: Text("Carrito")),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), title: Text("Ajustes")),
        ],
      ),
    );
  }
}
