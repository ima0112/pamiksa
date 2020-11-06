import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/blocs.dart';
import 'package:pamiksa/src/data/models/models.dart';
import 'package:pamiksa/src/ui/pages/pages.dart';
import 'package:shimmer/shimmer.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final ScrollController _scrollController = ScrollController();

  RootBloc homeBloc;
  ThemeBloc themeBloc;
  List<String> _list;

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

  @override
  void initState() {
    homeBloc = BlocProvider.of<RootBloc>(context);
    MySearchDelegate(words: _list, textInputType: TextInputType.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RootBloc, RootState>(
      builder: (context, state) {
        if (state is HomeInitial) {
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
                  elevation: 1.0,
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
        } else if (state is LoadedBusinessState) {
          final List<BusinessModel> businessData = state.results;
          return SafeArea(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  snap: true,
                  pinned: true,
                  forceElevated: true,
                  floating: true,
                  elevation: 1.0,
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
                      photoUrl: businessData[index].photoUrl,
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
        } else if (state is HomeConnectionFailedState) {
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
        } else
          return Container(
            child: Center(
              child: Text("Error"),
            ),
          );
      },
    );
  }
}
