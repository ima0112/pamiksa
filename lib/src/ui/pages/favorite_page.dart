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

  @override
  void initState() {
    favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
    favoriteBloc.add(FetchFavoritesFoodsEvent());
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        navigationService.navigateWithoutGoBack(Routes.HomeRoute);
        return false;
      },
      child: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state is LoadedFavoritesFoodsState) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  child: ListView.separated(
                    controller: _scrollController,
                    shrinkWrap: true,
                    itemCount: state.count,
                    itemBuilder: (_, index) => ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      title: Text("${state.favoriteModel[index].name}"),
                      subtitle:
                          Text("Precio: ${state.favoriteModel[index].price}"),
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
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
