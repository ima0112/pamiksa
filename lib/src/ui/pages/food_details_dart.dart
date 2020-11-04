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

  AddonsBloc addonsBloc;

  @override
  void initState() {
    addonsBloc = BlocProvider.of<AddonsBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      right: false,
      left: false,
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => null,
          label: Text("Agregar al carrito"),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Stack(
          children: <Widget>[
            CustomScrollView(
              controller: this._scrollController,
              slivers: <Widget>[
                appBar(),
                SliverList(
                    delegate: SliverChildListDelegate([AddonsItemPage()]))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget appBar() {
    return BlocBuilder<AddonsBloc, AddonsState>(
      builder: (context, state) {
        if (state is LoadingAddonssState) {
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
                    " ",
                    style: TextStyle(
                        color: Theme.of(context)
                            .appBarTheme
                            .textTheme
                            .bodyText1
                            .color),
                  )));
        } else if (state is LoadedAddonsState) {
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
                          "assets/images/profile.png",
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
}
