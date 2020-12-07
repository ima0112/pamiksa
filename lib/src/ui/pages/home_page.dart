import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/blocs.dart';
import 'package:pamiksa/src/ui/pages/pages.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RootBloc homeBloc;
  FavoriteBloc favoriteBloc;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  List list = [RootPage(), null, FavoritePage(), CartPage(), SettingsPage()];

  @override
  Widget build(BuildContext context) {
    homeBloc = BlocProvider.of<RootBloc>(context);
    favoriteBloc = BlocProvider.of<FavoriteBloc>(context);

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
          } else if (index == 2) {
            favoriteBloc.add(ChangeStateToInitialEvent());
            setState(() {
              _currentIndex = index;
            });
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: (Platform.isAndroid)
                  ? Icon(Icons.home)
                  : Icon(CupertinoIcons.home),
              title: Text("Inicio")),
          BottomNavigationBarItem(
              icon: (Platform.isAndroid)
                  ? Icon(Icons.search)
                  : Icon(CupertinoIcons.search),
              title: Text("Buscar")),
          BottomNavigationBarItem(
              icon: (Platform.isAndroid)
                  ? Icon(Icons.favorite_border)
                  : Icon(CupertinoIcons.heart),
              title: Text("Favoritos")),
          BottomNavigationBarItem(
              icon: (Platform.isAndroid)
                  ? Icon(Icons.shopping_cart)
                  : Icon(CupertinoIcons.shopping_cart),
              title: Text("Carrito")),
          BottomNavigationBarItem(
              icon: (Platform.isAndroid)
                  ? Icon(Icons.settings)
                  : Icon(CupertinoIcons.gear_solid),
              title: Text("Ajustes")),
        ],
      ),
    );
  }
}
