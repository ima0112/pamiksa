import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/blocs.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';
import 'package:pamiksa/src/ui/pages/pages.dart';

class FoodPage extends StatefulWidget {
  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  final ScrollController _scrollController = ScrollController();
  final NavigationService navigationService = locator<NavigationService>();

  FoodBloc foodBloc;

  String foodFK;
  int _isFavorite = 1;

  @override
  void initState() {
    foodBloc = BlocProvider.of<FoodBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodBloc, FoodState>(builder: (context, state) {
      if (state is FoodInitial) {
        foodFK = state.foodFk;
        foodBloc.add(FetchFoodEvent(state.foodFk));
        return SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: LinearProgressIndicator(),
          ),
        );
      } else if (state is LoadingFoodState) {
        return SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: LinearProgressIndicator(),
          ),
        );
      } else if (state is LoadedFoodWithOutAddonsState) {
        return AppBar(
          title: Text(state.foodModel.name),
        );
      } else if (state is LoadedFoodState) {
        _isFavorite = foodBloc.isFavorite;
        Widget favoriteIcon() {
          if (_isFavorite == 1) {
            return IconButton(
                icon: (Platform.isAndroid)
                    ? Icon(Icons.favorite)
                    : Icon(CupertinoIcons.heart),
                onPressed: () {
                  setState(() {
                    foodBloc
                        .add(ToggleIconViewFavoriteEvent(state.foodModel.id));
                  });
                },
                color: Colors.white,
                splashRadius: 1.0);
          } else {
            return IconButton(
                icon: (Platform.isAndroid)
                    ? Icon(Icons.favorite)
                    : Icon(CupertinoIcons.heart),
                onPressed: () {
                  setState(() {
                    foodBloc
                        .add(ToggleIconViewFavoriteEvent(state.foodModel.id));
                  });
                },
                color: Colors.white,
                splashRadius: 1.0);
          }
        }

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: (Platform.isAndroid)
                  ? Icon(Icons.close)
                  : Icon(CupertinoIcons.add),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              state.foodModel.name,
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
                    tag: state.foodModel.photo,
                    child: ClipRRect(
                      child: Stack(
                        children: [
                          Image.network(
                            state.foodModel.photoUrl,
                          ),
                          Positioned(
                            right: 2.0,
                            bottom: 0.0,
                            child: favoriteIcon(),
                          ),
                        ],
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
                            icon: (Platform.isAndroid)
                                ? Icon(Icons.remove)
                                : Icon(CupertinoIcons.minus_circled),
                            onPressed: () {},
                            iconSize: 20,
                            splashRadius: 20,
                          ),
                          Text("0"),
                          IconButton(
                            icon: (Platform.isAndroid)
                                ? Icon(Icons.add)
                                : Icon(CupertinoIcons.plus_circled),
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
            icon: (Platform.isAndroid)
                ? Icon(Icons.add_shopping_cart)
                : Icon(CupertinoIcons.shopping_cart),
            label: Text("Agregar al carrito"),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      } else if (state is ErrorFoodState) {
        return ErrorPage(event: state.event, bloc: foodBloc);
      } else {
        return ErrorPage(event: SetInitialFoodEvent(foodFK), bloc: foodBloc);
      }
    });
  }
}
