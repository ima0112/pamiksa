import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/blocs.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';
import 'package:pamiksa/src/ui/pages/pages.dart';

class FavoriteDetailsPage extends StatefulWidget {
  @override
  _FavoriteDetailsPageState createState() => _FavoriteDetailsPageState();
}

class _FavoriteDetailsPageState extends State<FavoriteDetailsPage> {
  final ScrollController _scrollController = ScrollController();
  final NavigationService navigationService = locator<NavigationService>();

  FavoriteDetailsBloc favoriteDetailsBloc;

  @override
  void initState() {
    favoriteDetailsBloc = BlocProvider.of<FavoriteDetailsBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      right: false,
      left: false,
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => null,
          label: Text("Agregar al carrito"),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: BlocBuilder<FavoriteDetailsBloc, FavoriteDetailsState>(
          builder: (context, state) {
            return Stack(
              children: <Widget>[
                CustomScrollView(
                  controller: this._scrollController,
                  slivers: <Widget>[
                    appBar(),
                    SliverList(delegate: SliverChildListDelegate([details()]))
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget appBar() {
    return BlocBuilder<FavoriteDetailsBloc, FavoriteDetailsState>(
      builder: (context, state) {
        if (state is LoadingFavoritesDetailsFoodsState) {
          return SliverAppBar(
              pinned: true,
              backgroundColor: Theme.of(context).appBarTheme.color,
              expandedHeight: 200,
              elevation: 2.0,
              flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: double.maxFinite,
                        child: Image.asset(
                          "assets/images/image_color_gray_transparent_background.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        width: double.maxFinite,
                        height: double.maxFinite,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.transparent.withOpacity(0.0),
                                  Colors.black87
                                ],
                                stops: [
                                  0.5,
                                  1.0
                                ])),
                      ),
                    ],
                  ),
                  centerTitle: false,
                  title: Text(
                    " ",
                    style: TextStyle(
                        color: Theme.of(context)
                            .appBarTheme
                            .textTheme
                            .bodyText1
                            .color),
                  )));
        } else if (state is LoadedFavoritesFoodsWithOutAddonsState) {
          return SliverAppBar(
              pinned: true,
              backgroundColor: Theme.of(context).appBarTheme.color,
              expandedHeight: 200,
              elevation: 2.0,
              stretch: true,
              flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: double.maxFinite,
                        child: Image.network(
                          state.favoriteModel.photoUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        width: double.maxFinite,
                        height: double.maxFinite,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.transparent.withOpacity(0.0),
                                  Colors.black54
                                ],
                                stops: [
                                  0.5,
                                  1.0
                                ])),
                      ),
                    ],
                  ),
                  centerTitle: false,
                  title: Text(
                    "",
                    style: TextStyle(
                        color: Theme.of(context)
                            .appBarTheme
                            .textTheme
                            .bodyText1
                            .color),
                  )));
        } else if (state is LoadedFavoritesFoodsDetailsState) {
          return SliverAppBar(
              pinned: true,
              backgroundColor: Theme.of(context).appBarTheme.color,
              expandedHeight: 200,
              elevation: 2.0,
              stretch: true,
              flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: double.maxFinite,
                        child: Image.network(
                          state.favoriteModel.photoUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        width: double.maxFinite,
                        height: double.maxFinite,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.transparent.withOpacity(0.0),
                                  Colors.black54
                                ],
                                stops: [
                                  0.5,
                                  1.0
                                ])),
                      ),
                    ],
                  ),
                  centerTitle: false,
                  title: Text(
                    "",
                    style: TextStyle(
                        color: Theme.of(context)
                            .appBarTheme
                            .textTheme
                            .bodyText1
                            .color),
                  )));
        }
        return SliverAppBar(
            pinned: true,
            backgroundColor: Theme.of(context).appBarTheme.color,
            expandedHeight: 200,
            elevation: 2.0,
            flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      child: Image.asset(
                        "assets/images/image_color_gray_transparent_background.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.transparent.withOpacity(0.0),
                                Colors.black87
                              ],
                              stops: [
                                0.5,
                                1.0
                              ])),
                    ),
                  ],
                ),
                centerTitle: false,
                title: Text(
                  " ",
                  style: TextStyle(
                      color: Theme.of(context)
                          .appBarTheme
                          .textTheme
                          .bodyText1
                          .color),
                )));
      },
    );
  }

  Widget details() {
    return BlocBuilder<FavoriteDetailsBloc, FavoriteDetailsState>(
      builder: (context, state) {
        if (state is LoadingFavoritesDetailsFoodsState) {
          return Center(
            child: Align(
              alignment: Alignment.topCenter,
              child: LinearProgressIndicator(),
            ),
          );
        } else if (state is LoadedFavoritesFoodsWithOutAddonsState) {
          return Container();
        } else if (state is LoadedFavoritesFoodsDetailsState) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: ListView.separated(
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemCount: state.count,
                  itemBuilder: (_, index) => ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    title: Text("${state.addonsModel[index].name}"),
                    subtitle: Text("Precio: ${state.addonsModel[index].price}"),
                    trailing: Container(
                      height: 50,
                      width: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {},
                            iconSize: 20,
                            splashRadius: 20,
                          ),
                          Text("0"),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {},
                            iconSize: 20,
                            splashRadius: 20,
                          ),
                        ],
                      ),
                    ),
                    dense: true,
                  ),
                  separatorBuilder: (_, __) => Divider(
                    height: 20.0,
                  ),
                ),
              ),
            ],
          );
        }
        return Center(
            child: FlatButton.icon(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                onPressed: () {},
                icon: Icon(Icons.refresh),
                label: Text("Reintentar")));
      },
    );
  }
}
