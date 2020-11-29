import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/blocs.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';

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
    return BlocBuilder<FavoriteDetailsBloc, FavoriteDetailsState>(
        builder: (context, state) {
      if (state is LoadingFavoritesDetailsFoodsState) {
        return Center(
          child: Align(
            alignment: Alignment.topCenter,
            child: CircularProgressIndicator(),
          ),
        );
      } else if (state is LoadedFavoritesFoodsWithOutAddonsState) {
        return Center(
          child: Align(
            alignment: Alignment.topCenter,
            child: CircularProgressIndicator(),
          ),
        );
      } else if (state is LoadedFavoritesFoodsDetailsState) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              state.favoriteModel.name,
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color,
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: Column(
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                  child: Hero(
                    tag: state.favoriteModel.photo,
                    child: ClipRRect(
                      child: Image.network(
                        state.favoriteModel.photoUrl,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  )),
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
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => null,
            icon: Icon(Icons.add_shopping_cart),
            label: Text("Agregar al carrito"),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      }
    });
  }
}