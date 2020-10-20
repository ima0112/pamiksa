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
  ThemeBloc themeBloc;
  MySearchDelegate _delegate;
  List<String> _list;
  int _currentIndex = 0;

  @override
  void initState() {
    themeBloc = BlocProvider.of<ThemeBloc>(context);
    themeBloc.add(LoadedThemeEvent());
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

  List list = [RootPage()];

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
              icon: Icon(Icons.favorite_border), title: Text("Favorito")),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), title: Text("Ajustes")),
        ],
      ),
    );
  }
}

class HomeActions extends StatefulWidget {
  final MySearchDelegate delegate;
  final List<String> list;

  const HomeActions({Key key, this.delegate, this.list}) : super(key: key);

  @override
  _HomeActionsState createState() => _HomeActionsState();
}

class _HomeActionsState extends State<HomeActions> {
  final ScrollController _scrollController = ScrollController();

  RootBloc homeBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    homeBloc = BlocProvider.of<RootBloc>(context);
    final RootState currentState = homeBloc.state;
    if (currentState is ShowThirdState) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: ListView.separated(
              controller: _scrollController,
              shrinkWrap: true,
              itemCount: currentState.count,
              itemBuilder: (_, index) => ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                title: Text("${currentState.favoriteModel[index].name}"),
                subtitle:
                    Text("Precio: ${currentState.favoriteModel[index].price}"),
                trailing: Image.asset("assets/images/profile.png"),
                dense: true,
              ),
              separatorBuilder: (_, __) => Divider(
                height: 20.0,
              ),
            ),
          ),
        ],
      );
    } else if (currentState is ShowSecondState) {
      showSearch(context: context, delegate: this.widget.delegate);
      // Center(
      //   child: Text(
      //     "Second View",
      //     style: TextStyle(
      //         fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: 2.0),
      //   ),
      // );
    } else if (currentState is ShowFourState) {
      return SettingsPage();
    }
  }
}
