import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/blocs.dart';
import 'package:pamiksa/src/data/models/models.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
import 'package:pamiksa/src/ui/pages/pages.dart';
import 'package:pamiksa/src/ui/widgets/food_list_skeleton.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final NavigationService navigationService = locator<NavigationService>();
  final ScrollController _scrollController = ScrollController();
  List<FavoriteModel> favoriteModel;
  FavoriteBloc favoriteBloc;
  FavoriteDetailsBloc favoriteDetailsBloc;
  StreamController streamController;

  @override
  void initState() {
    favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
    favoriteDetailsBloc = BlocProvider.of<FavoriteDetailsBloc>(context);
    streamController = favoriteBloc.streamController;
    if (!streamController.hasListener) {
      streamController.stream.listen((data) {
        print("DataReceived");
        setState(() {
          favoriteModel = data;
        });
      }, onDone: () {
        print("Task Done");
      }, onError: (error) {
        print("Some Error");
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    //streamController.close(); //Streams must be closed when not needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favoritos",
          style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          navigationService.navigateWithoutGoBack(Routes.HomeRoute);
          return false;
        },
        child: BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (context, state) {
            if (state is FavoriteInitial) {
              favoriteBloc.add(FetchFavoritesFoodsEvent());
              return FoodListSkeleton();
            } else if (state is LoadedFavoritesFoodsState) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.separated(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: state.count,
                      itemBuilder: (_, index) => ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 15.0),
                        title: Text(
                          state.favoriteModel[index].name,
                          style: TextStyle(fontSize: 14.0),
                        ),
                        onTap: () {
                          favoriteDetailsBloc.add(
                              FetchFavoriteFoodsDetailsEvent(
                                  state.favoriteModel[index].id));
                          navigationService
                              .navigateTo(Routes.FavoriteDetailsRoute);
                        },
                        subtitle: Text(
                          "\$ ${state.favoriteModel[index].price}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        leading: Hero(
                          tag: state.favoriteModel[index].photo,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(7.5),
                            child: FadeInImage(
                              imageErrorBuilder: (context, error, stackTrace) {
                                if (Theme.of(context).brightness ==
                                    Brightness.dark) {
                                  return Image.asset(
                                      "assets/gif/dark_loading.gif");
                                } else {
                                  return Image.asset("assets/gif/loading.gif");
                                }
                              },
                              fit: BoxFit.fitWidth,
                              width: 80,
                              image: NetworkImage(
                                state.favoriteModel[index].photoUrl,
                              ),
                              placeholder: (Theme.of(context).brightness ==
                                      Brightness.dark)
                                  ? AssetImage("assets/gif/dark_loading.gif")
                                  : AssetImage("assets/gif/loading.gif"),
                            ),
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            favoriteBloc.add(DeleteFavoriteEvent(
                                state.favoriteModel[index], state));
                          },
                        ),
                        dense: true,
                      ),
                      separatorBuilder: (_, __) => Divider(height: 0.0),
                    )
                  ],
                ),
              );
            } else if (state is DeleteFavoriteLoaded) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.separated(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: favoriteModel.length,
                      itemBuilder: (_, index) => ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 15.0),
                        title: Text(
                          favoriteModel[index].name,
                          style: TextStyle(fontSize: 14.0),
                        ),
                        onTap: () {
                          favoriteDetailsBloc.add(
                              FetchFavoriteFoodsDetailsEvent(
                                  favoriteModel[index].id));
                          navigationService
                              .navigateTo(Routes.FavoriteDetailsRoute);
                        },
                        subtitle: Text(
                          "\$ ${favoriteModel[index].price}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        leading: Hero(
                          tag: favoriteModel[index].photo,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(7.5),
                            child: FadeInImage(
                              fit: BoxFit.fitWidth,
                              width: 80,
                              image: NetworkImage(
                                favoriteModel[index].photoUrl,
                              ),
                              placeholder: (Theme.of(context).brightness ==
                                      Brightness.dark)
                                  ? AssetImage("assets/gif/dark_loading.gif")
                                  : AssetImage("assets/gif/loading.gif"),
                            ),
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            favoriteBloc.add(DeleteFavoriteEvent(
                                favoriteModel[index], state));
                          },
                        ),
                        dense: true,
                      ),
                      separatorBuilder: (_, __) => Divider(height: 0.0),
                    )
                  ],
                ),
              );
            } else if (state is ErrorFavoriteState) {
              return ErrorPage(event: state.event, bloc: favoriteBloc);
            }
            return ErrorPage(
                event: SetInitialFavoriteEvent(), bloc: favoriteBloc);
          },
        ),
      ),
    );
  }
}
