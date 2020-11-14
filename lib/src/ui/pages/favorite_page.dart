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
  FoodBloc addonsBloc;

  @override
  void initState() {
    addonsBloc = BlocProvider.of<FoodBloc>(context);
    favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
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
            } else if (state is FavoriteRefreshTokenExpired) {
              favoriteBloc.add(SessionExpiredEvent());
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
                          FetchFoodEvent(state.favoriteModel[index].id);
                          navigationService.navigateTo(Routes.FoodRoute);
                        },
                        subtitle:
                            Text("Precio: ${state.favoriteModel[index].price}"),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(7.5),
                          child: Image.network(
                            state.favoriteModel[index].photoUrl,
                            fit: BoxFit.fitHeight,
                            height: 100,
                          ),
                        ),
                        dense: true,
                      ),
                      separatorBuilder: (_, __) => Divider(
                        height: 0.0,
                      ),
                    ),
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
