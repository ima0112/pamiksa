import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
            } else if (state is FavoriteTokenExpired) {
              favoriteBloc.add(FavoriteRefreshTokenEvent());
              return Center(child: CircularProgressIndicator());
            } else if (state is LoadedFavoritesFoodsState) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                      child: ListView.separated(
                        controller: _scrollController,
                        shrinkWrap: true,
                        itemCount: state.count,
                        itemBuilder: (_, index) => ListTile(
                          onTap: () {
                            addonsBloc.add(
                                FetchFoodEvent(state.favoriteModel[index].id));
                            navigationService.navigateTo(Routes.FoodRoute);
                          },
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          title: Text("${state.favoriteModel[index].name}"),
                          subtitle: Text(
                              "Precio: ${state.favoriteModel[index].price}"),
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
                          height: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
