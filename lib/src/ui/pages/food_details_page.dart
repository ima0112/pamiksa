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

  FoodBloc addonsBloc;

  @override
  void initState() {
    addonsBloc = BlocProvider.of<FoodBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodBloc, FoodState>(builder: (context, state) {
      if (state is LoadingFoodState) {
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (state is LoadedFoodState) {
        return SafeArea(
          top: false,
          bottom: false,
          right: false,
          left: false,
          child: Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () => null,
              icon: Icon(Icons.add_shopping_cart),
              label: Text("Agregar al carrito"),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: Stack(
              children: <Widget>[
                CustomScrollView(
                  controller: this._scrollController,
                  slivers: <Widget>[
                    appBar(),
                    SliverList(
                        delegate: SliverChildListDelegate([
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(state.foodModel[0].name, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                            SizedBox(height: 1.5),
                            Text(state.foodModel[0].description),
                            SizedBox(height: 1.5),
                            Text('\$ ${state.foodModel[0].price}'),
                          ],
                        ),
                      )
                    ])),
                    SliverList(delegate: SliverChildListDelegate([details()]))
                  ],
                ),
              ],
            ),
          ),
        );
      } else {
        return SafeArea(
          top: false,
          bottom: false,
          right: false,
          left: false,
          child: Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () => null,
              icon: Icon(Icons.add_shopping_cart),
              label: Text("Agregar al carrito"),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: Stack(
              children: <Widget>[
                CustomScrollView(
                  controller: this._scrollController,
                  slivers: <Widget>[
                    appBar(),
                    SliverList(
                        delegate: SliverChildListDelegate([
                      Text("Hello World"),
                    ])),
                    SliverList(delegate: SliverChildListDelegate([details()]))
                  ],
                ),
              ],
            ),
          ),
        );
      }
    });
  }

  Widget appBar() {
    return BlocBuilder<FoodBloc, FoodState>(
      builder: (context, state) {
        if (state is LoadingFoodState) {
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
        } else if (state is LoadedFoodState) {
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
                          state.foodModel[0].photoUrl,
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
        return null;
      },
    );
  }

  Widget details() {
    return BlocBuilder<FoodBloc, FoodState>(
      builder: (context, state) {
        if (state is LoadingFoodState) {
          return Center(
            child: Align(
              alignment: Alignment.topCenter,
              child: LinearProgressIndicator(),
            ),
          );
        } else if (state is LoadedFoodState) {
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
        return null;
      },
    );
  }
}
