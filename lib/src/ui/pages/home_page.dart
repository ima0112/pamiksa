import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/blocs.dart';
import 'package:pamiksa/src/data/models/business.dart';
import 'package:pamiksa/src/ui/pages/pages.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc homeBloc;
  ThemeBloc themeBloc;

  @override
  void initState() {
    themeBloc = BlocProvider.of<ThemeBloc>(context);
    themeBloc.add(LoadedThemeEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    homeBloc = BlocProvider.of<HomeBloc>(context);
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: AppBar(
              backgroundColor: Theme.of(context).primaryColorLight,
              automaticallyImplyLeading: false,
              elevation: 0.0,
            )),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (previousState, state) =>
                  state.runtimeType != previousState.runtimeType,
              builder: (context, state) => HomeActions(),
            );
          },
        ),
        bottomNavigationBar: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 12.0,
            unselectedFontSize: 12.0,
            currentIndex: state.index,
            onTap: (index) =>
                homeBloc.add(BottomNavigationItemTappedEvent(index)),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.format_list_bulleted),
                  title: Text("Inicio")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), title: Text("Buscar")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border), title: Text("Favorito")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), title: Text("Ajustes")),
            ],
          ),
        ));
  }
}

class HomeActions extends StatefulWidget {
  @override
  _HomeActionsState createState() => _HomeActionsState();
}

class _HomeActionsState extends State<HomeActions> {
  final ScrollController _scrollController = ScrollController();

  HomeBloc homeBloc;

  @override
  Widget build(BuildContext context) {
    homeBloc = BlocProvider.of<HomeBloc>(context);
    final HomeState currentState = homeBloc.state;
    if (currentState is HomeInitial) {
      homeBloc.add(FetchBusinessEvent());
      return Center(
          child: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              snap: true,
              pinned: true,
              forceElevated: true,
              floating: true,
              elevation: 2.0,
              title: Text(
                "Cargando...",
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color,
                    fontWeight: FontWeight.bold),
              ),
              expandedHeight: 2 * kToolbarHeight,
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(top: kToolbarHeight),
                child: Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10.0),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Chip(
                          avatar: Icon(Icons.filter_list),
                          label: Text("Filtrar"),
                        ),
                        SizedBox(width: 10),
                        Chip(
                          label: Text("Para Recojer"),
                          avatar: Icon(Icons.store),
                        ),
                        SizedBox(width: 10),
                        Chip(
                          label: Text("A Domicilio"),
                          avatar: Icon(Icons.directions_bike),
                        )
                      ],
                    )),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              ListView.separated(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (_, index) => Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[200],
                    child: BusinessItemSkeletonPage()),
                separatorBuilder: (_, __) => Divider(height: 0.0),
              )
            ]))
          ],
        ),
      ));
    } else if (currentState is LoadedBusinessState) {
      final List<BusinessModel> businessData = currentState.results;
      return SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              snap: true,
              pinned: true,
              forceElevated: true,
              floating: true,
              elevation: 2.0,
              title: Text(
                "Pamiksa",
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color,
                    fontWeight: FontWeight.bold),
              ),
              expandedHeight: 2 * kToolbarHeight,
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(top: kToolbarHeight),
                child: Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10.0),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Chip(
                          avatar: Icon(Icons.filter_list),
                          label: Text("Filtrar"),
                        ),
                        SizedBox(width: 10),
                        Chip(
                          label: Text("Para Recojer"),
                          avatar: Icon(Icons.store),
                        ),
                        SizedBox(width: 10),
                        Chip(
                          label: Text("A Domicilio"),
                          avatar: Icon(Icons.directions_bike),
                        )
                      ],
                    )),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              ListView.separated(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: businessData.length,
                itemBuilder: (_, index) => BusinessItemPage(
                  id: businessData[index].id,
                  name: businessData[index].name,
                  photo: businessData[index].photo,
                  adress: businessData[index].adress,
                  valoration: businessData[index].valoration,
                  deliveryPrice: businessData[index].deliveryPrice,
                ),
                separatorBuilder: (_, __) => Divider(height: 0.0),
              )
            ]))
          ],
        ),
      );
    } else if (currentState is ShowSecondState) {
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
    } else if (currentState is ShowThirdState) {
      return Center(
        child: Text(
          "Third View",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: 2.0),
        ),
      );
    } else if (currentState is ShowFourState) {
      return SettingsPage();
    } else if (currentState is HomeConnectionFailedState) {
      return Center(
          child: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              snap: true,
              pinned: true,
              forceElevated: true,
              floating: true,
              elevation: 1.0,
              title: Text(
                "Sin Conexión",
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color,
                    fontWeight: FontWeight.bold),
              ),
              expandedHeight: 2 * kToolbarHeight,
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(top: kToolbarHeight),
                child: Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10.0),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Chip(
                          avatar: Icon(Icons.filter_list),
                          label: Text("Filtrar"),
                        ),
                        SizedBox(width: 10),
                        Chip(
                          label: Text("Para Recojer"),
                          avatar: Icon(Icons.store),
                        ),
                        SizedBox(width: 10),
                        Chip(
                          label: Text("A Domicilio"),
                          avatar: Icon(Icons.directions_bike),
                        )
                      ],
                    )),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              Container(
                //color: Colors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 12.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Text(
                        "Parece que tienes problemas en la conexión. Compruébalo y prueba otra vez.",
                        style: TextStyle(color: Colors.grey[700]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    FlatButton.icon(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        onPressed: () {
                          homeBloc.add(ChangeToInitialStateEvent());
                        },
                        icon: Icon(Icons.refresh),
                        label: Text("Reintentar"))
                  ],
                ),
              )
            ]))
          ],
        ),
      ));
    }
  }
}
