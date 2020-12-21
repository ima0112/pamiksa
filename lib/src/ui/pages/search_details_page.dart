import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/search_details/search_details_bloc.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';
import 'package:pamiksa/src/ui/pages/pages.dart';

class SearchDetailsPage extends StatefulWidget {
  @override
  _SearchDetailsPageState createState() => _SearchDetailsPageState();
}

class _SearchDetailsPageState extends State<SearchDetailsPage> {
  final ScrollController _scrollController = ScrollController();
  final NavigationService navigationService = locator<NavigationService>();

  SearchDetailsBloc searchDetailsBloc;

  @override
  void initState() {
    searchDetailsBloc = BlocProvider.of<SearchDetailsBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchDetailsBloc, SearchDetailsState>(
        builder: (context, state) {
      if (state is LoadingSearchDetailsState) {
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (state is LoadedSearchDetailWithOutAddonsState) {
        return AppBar(
          title: Text(state.searchModel.name),
        );
      } else if (state is LoadedSearchDetailsState) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                navigationService.navigateWithoutGoBack(Routes.HomeRoute);
              },
            ),
            title: Text(
              state.searchModel.name,
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
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                    child: Hero(
                      tag: state.searchModel.photo,
                      child: ClipRRect(
                        child: Image.network(
                          state.searchModel.photoUrl,
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
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      title: Text("${state.addonsModel[index].name}"),
                      subtitle:
                          Text("Precio: ${state.addonsModel[index].price}"),
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
      } else if (state is ErrorSearchDetailsState) {
        return ErrorPage(event: state.event, bloc: searchDetailsBloc);
      } else {
        return ErrorPage(
            event: SearchDetailsInitial(), bloc: searchDetailsBloc);
      }
    });
  }
}
