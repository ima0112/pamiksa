import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/blocs.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final NavigationService navigationService = locator<NavigationService>();
  final ScrollController _scrollController = ScrollController();

  FavoriteBloc favoriteBloc;
  FavoriteDetailsBloc favoriteDetailsBloc;

  @override
  void initState() {
    favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
    favoriteDetailsBloc = BlocProvider.of<FavoriteDetailsBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
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
              return Center(child: CircularProgressIndicator());
            } else if (state is FavoriteTokenExpired) {
              favoriteBloc.add(FavoriteRefreshTokenEvent());
              return Center(child: CircularProgressIndicator());
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
                            child: Image.network(
                              state.favoriteModel[index].photoUrl,
                              fit: BoxFit.fitWidth,
                              width: 80,
                            ),
                          ),
                        ),
                        dense: true,
                      ),
                      separatorBuilder: (_, __) => Divider(height: 0.0),
                    )
                  ],
                ),
              );
            }
            return Center(
                child: FlatButton.icon(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    onPressed: () {
                      favoriteBloc.add(ChangeStateToInitialEvent());
                    },
                    icon: Icon(Icons.refresh),
                    label: Text("Reintentar")));
          },
        ),
      ),
    );
  }
}
