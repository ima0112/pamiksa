import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/home/home_bloc.dart';
import 'package:pamiksa/src/data/models/business.dart';
import 'package:pamiksa/src/ui/views/home/business_item.dart';
import 'package:pamiksa/src/ui/views/home/settings.dart';
import 'package:shimmer/shimmer.dart';
import 'package:pamiksa/src/ui/views/home/business_item_skeleton.dart';

class Home extends StatelessWidget {
  HomeBloc homeBloc;

  @override
  Widget build(BuildContext context) {
    homeBloc = BlocProvider.of<HomeBloc>(context);
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0.0,
              backgroundColor: Color(0xffF5F5F5),
              brightness: Brightness.light,
            )),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (previousState, state) =>
                  state.runtimeType != previousState.runtimeType,
              builder: (context, state) => Actions(),
            );
          },
        ),
        bottomNavigationBar: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) => BottomNavigationBar(
            currentIndex: state.index,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.deepPurpleAccent[700],
            onTap: (index) =>
                homeBloc.add(BottomNavigationItemTappedEvent(index)),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.format_list_bulleted),
                  title: Text("Inicio")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), title: Text("Buscar")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), title: Text("Ajustes")),
            ],
          ),
        ));
  }
}

class Actions extends StatefulWidget {
  @override
  _ActionsState createState() => _ActionsState();
}

class _ActionsState extends State<Actions> {
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
              backgroundColor: Colors.white,
              snap: true,
              pinned: true,
              forceElevated: true,
              floating: true,
              elevation: 2.0,
              title: Text(
                "Cargando...",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              actions: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.black,
                    ),
                    onPressed: () {}),
              ],
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
                    child: BusinessItemSkeleton()),
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
              backgroundColor: Colors.white,
              snap: true,
              pinned: true,
              forceElevated: true,
              floating: true,
              elevation: 2.0,
              title: Text(
                "Pamiksa",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              actions: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.black,
                    ),
                    onPressed: () {}),
              ],
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
                itemBuilder: (_, index) => BusinessItem(
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
      return Center(
        child: Text(
          "Second View",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: 2.0),
        ),
      );
    } else if (currentState is ShowThirdState) {
      return Settings();
    } else if (currentState is ConnectionFailedState) {
      return Center(
          child: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              snap: true,
              pinned: true,
              forceElevated: true,
              floating: true,
              elevation: 1.0,
              title: Text(
                "Sin Conexión",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              actions: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.black,
                    ),
                    onPressed: () {}),
              ],
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
