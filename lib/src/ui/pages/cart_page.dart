import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/cart/cart_bloc.dart';
import 'package:pamiksa/src/ui/widgets/food_list_skeleton.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CartBloc cartBloc;
  final ScrollController _scrollController = ScrollController();

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
            ),
            body: FoodListSkeleton());
      } else if (state is LoadingCartState) {
        return Scaffold(
            appBar: AppBar(
              title: Text(
                "Carrito",
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: FoodListSkeleton());
      } else if (state is LoadedCartState) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Carrito",
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1.color,
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ListView.separated(
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemCount: state.cartFoodModel.length,
                  itemBuilder: (_, index) => ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                    title: Text(
                      state.cartFoodModel[index].name,
                      style: TextStyle(fontSize: 14.0),
                    ),
                    onTap: () {
                      // favoriteDetailsBloc.add(
                      //     FetchFavoriteFoodsDetailsEvent(
                      //         state.cartFoodModel[index].id));
                      // navigationService
                      //     .navigateTo(Routes.FavoriteDetailsRoute);
                    },
                    subtitle: Text(
                      "\$ ${state.cartFoodModel[index].price}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    leading: Hero(
                      tag: state.cartFoodModel[index].photo,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(7.5),
                        child: FadeInImage(
                          imageErrorBuilder: (context, error, stackTrace) {
                            if (Theme.of(context).brightness ==
                                Brightness.dark) {
                              return Image.asset("assets/gif/dark_loading.gif");
                            } else {
                              return Image.asset("assets/gif/loading.gif");
                            }
                          },
                          fit: BoxFit.fitWidth,
                          width: 80,
                          image: NetworkImage(
                            state.cartFoodModel[index].photoUrl,
                          ),
                          placeholder:
                              (Theme.of(context).brightness == Brightness.dark)
                                  ? AssetImage("assets/gif/dark_loading.gif")
                                  : AssetImage("assets/gif/loading.gif"),
                        ),
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        // favoriteBloc.add(DeleteFavoriteEvent(
                        //     state.favoriteModel[index], state));
                      },
                    ),
                    dense: true,
                  ),
                  separatorBuilder: (_, __) => Divider(height: 0.0),
                )
              ],
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
            body: Container(
              child: Center(
                child: Text('Cargado o Error'),
              ),
            ));
      }
    });
  }
}
