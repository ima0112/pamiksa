import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/cart/cart_bloc.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';
import 'package:pamiksa/src/ui/widgets/food_list_skeleton.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CartBloc cartBloc;
  final ScrollController _scrollController = ScrollController();
  final NavigationService navigationService = locator<NavigationService>();
  final List<String> choices = ['Vaciar el carrito'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    cartBloc = BlocProvider.of<CartBloc>(context);

    return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
      if (state is CartInitial) {
        cartBloc.add(FetchCartEvent());
        return Scaffold(
            appBar: AppBar(
              title: Text(
                "Carrito",
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color,
                    fontWeight: FontWeight.bold),
              ),
              actions: [
                IconButton(icon: Icon(Icons.more_vert), onPressed: () {})
              ],
            ),
            body: WillPopScope(
                onWillPop: () async {
                  navigationService.navigateWithoutGoBack(Routes.HomeRoute);
                  return false;
                },
                child: FoodListSkeleton()));
      } else if (state is LoadingCartState) {
        return Scaffold(
            appBar: AppBar(
              title: Text(
                "Carrito",
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color,
                    fontWeight: FontWeight.bold),
              ),
              actions: [
                IconButton(icon: Icon(Icons.more_vert), onPressed: () {})
              ],
            ),
            body: WillPopScope(
                onWillPop: () async {
                  navigationService.navigateWithoutGoBack(Routes.HomeRoute);
                  return false;
                },
                child: FoodListSkeleton()));
      } else if (state is LoadedCartState) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Carrito",
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color,
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              PopupMenuButton<String>(
                onSelected: choiceAction,
                itemBuilder: (BuildContext context) {
                  return choices.map((String choice) {
                    return PopupMenuItem<String>(
                        value: choice, child: Text(choice));
                  }).toList();
                },
              )
            ],
          ),
          body: WillPopScope(
            onWillPop: () async {
              navigationService.navigateWithoutGoBack(Routes.HomeRoute);
              return false;
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.separated(
                    controller: _scrollController,
                    shrinkWrap: true,
                    itemCount: state.cartFoodViewModel.length,
                    itemBuilder: (_, index) => ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 15.0),
                      title: Text(
                        state.cartFoodViewModel[index].name,
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        // favoriteDetailsBloc.add(
                        //     FetchFavoriteFoodsDetailsEvent(
                        //         state.cartFoodModel[index].id));
                        // navigationService
                        //     .navigateTo(Routes.FavoriteDetailsRoute);
                      },
                      subtitle: Text(
                        "+${state.cartFoodViewModel[index].quantity}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      leading: Hero(
                        tag: state.cartFoodViewModel[index].photo,
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
                              state.cartFoodViewModel[index].photoUrl,
                            ),
                            placeholder: (Theme.of(context).brightness ==
                                    Brightness.dark)
                                ? AssetImage("assets/gif/dark_loading.gif")
                                : AssetImage("assets/gif/loading.gif"),
                          ),
                        ),
                      ),
                      trailing: Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            borderRadius: BorderRadius.circular(25.0)),
                        child: Text(
                          "\$ ${state.cartFoodViewModel[index].price}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      //     Text(
                      //   "\$ ${state.cartFoodViewModel[index].price}",
                      //   style: TextStyle(fontWeight: FontWeight.bold),
                      // ),
                      dense: true,
                    ),
                    separatorBuilder: (_, __) => Divider(height: 0.0),
                  )
                ],
              ),
            ),
          ),
        );
      } else if (state is EmptyCartState) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Carrito",
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color,
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              PopupMenuButton<String>(
                onSelected: choiceAction,
                itemBuilder: (BuildContext context) {
                  return choices.map((String choice) {
                    return PopupMenuItem<String>(
                        value: choice, child: Text(choice));
                  }).toList();
                },
              )
            ],
          ),
          body: WillPopScope(
            onWillPop: () async {
              navigationService.navigateWithoutGoBack(Routes.HomeRoute);
              return false;
            },
            child: SingleChildScrollView(
              child: Column(
                children: [],
              ),
            ),
          ),
        );
      } else {
        return Scaffold(
            appBar: AppBar(
              title: Text(
                "Carrito",
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
              child: Container(
                child: Center(
                  child: Text('Cargado o Error'),
                ),
              ),
            ));
      }
    });
  }

  void choiceAction(String choice) {
    if (choice == 'Vaciar el carrito') {
      cartBloc.add(EmptyCartEvent());
    }
  }
}
