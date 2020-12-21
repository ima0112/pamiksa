import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/blocs.dart';
import 'package:pamiksa/src/blocs/search_details/search_details_bloc.dart';
import 'package:pamiksa/src/data/models/models.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';
import 'package:pamiksa/src/ui/pages/pages.dart';
import 'package:pamiksa/src/ui/widgets/food_list_skeleton.dart';

class FoodSearch extends SearchDelegate<SearchModel> {
  final ScrollController _scrollController = ScrollController();
  final NavigationService navigationService = locator<NavigationService>();

  SearchBloc searchBloc;
  SearchDetailsBloc searchDetailsBloc;

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
        primaryColor: Theme.of(context).appBarTheme.color,
        textTheme: Theme.of(context).textTheme);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      if (query.isNotEmpty)
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: (Platform.isAndroid)
            ? Icon(Icons.arrow_back)
            : Icon(Icons.arrow_back_ios),
        color: Theme.of(context).iconTheme.color,
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    searchDetailsBloc = BlocProvider.of<SearchDetailsBloc>(context);
    searchBloc = BlocProvider.of<SearchBloc>(context);

    if (validate(query) == false) {
      searchBloc.add(SearchFoodEvent(query));
    }

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (query.isEmpty) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [Text("No has hecho ninguna busqueda")],
              ),
            ),
          );
        } else if (validate(query)) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [Text("No hay resultados")],
              ),
            ),
          );
        } else if (state is ErrorSearchState) {
          return ErrorPage(event: state.event, bloc: searchBloc);
        } else if (state is FoodsFoundState) {
          if (state.searchModel.length == 0) {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [Text("No hay resultados")],
                ),
              ),
            );
          } else if (state is SearchingFoodsState) {
            return FoodListSkeleton();
          }
          return ListView.separated(
            controller: _scrollController,
            shrinkWrap: true,
            separatorBuilder: (_, __) => Divider(height: 0.0),
            itemCount: state.searchModel.length,
            itemBuilder: (context, index) {
              final String result = state.searchModel[index].name;
              return ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
                subtitle: Text(
                  "\$ ${state.searchModel[index].price}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Hero(
                  tag: state.searchModel[index].photo,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7.5),
                    child: FadeInImage(
                      imageErrorBuilder: (context, error, stackTrace) {
                        if (Theme.of(context).brightness == Brightness.dark) {
                          return Image.asset("assets/gif/dark_loading.gif");
                        } else {
                          return Image.asset("assets/gif/loading.gif");
                        }
                      },
                      fit: BoxFit.fitWidth,
                      width: 80,
                      image: NetworkImage(
                        state.searchModel[index].photoUrl,
                      ),
                      placeholder: AssetImage("assets/gif/loading.gif"),
                    ),
                  ),
                ),
                title: RichText(
                    text: TextSpan(
                        text: result.substring(0, query.length),
                        style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1.color),
                        children: [
                      TextSpan(
                        text: result.substring(query.length),
                        style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1.color),
                      )
                    ])),
                onTap: () async {
                  searchDetailsBloc
                      .add(FetchSearchDetailEvent(state.searchModel[index].id));
                  await navigationService.navigateTo(Routes.SearchDetailsRoute);
                  close(context, state.searchModel[index]);
                },
              );
            },
          );
        }
        return FoodListSkeleton();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    searchBloc = BlocProvider.of<SearchBloc>(context);
    searchBloc.add(SearchSuggestionsEvent(query));

    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      if (state is SuggestionsState) {
        if (state.suggestions.length == 0) {
          return Container();
        } else if (query.isEmpty) {
          return ListView.builder(
            itemCount: state.suggestions.length,
            itemBuilder: (context, index) {
              final String suggestion = state.suggestions[index].name;
              return ListTile(
                trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      searchBloc.add(
                          DeleteSuggestionsEvent(state.suggestions[index].id));
                      searchBloc.add(SearchSuggestionsEvent(query));
                    }),
                leading: query.isEmpty ? Icon(Icons.history) : Icon(null),
                title: RichText(
                    text: TextSpan(
                        text: suggestion.substring(0, query.length),
                        style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1.color),
                        children: [
                      TextSpan(
                        text: suggestion.substring(query.length),
                        style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText1.color),
                      )
                    ])),
                onTap: () {
                  query = suggestion;
                  showResults(context);
                },
              );
            },
          );
        }

        final result = state.suggestions
            .where((element) => element.name.toLowerCase().contains(query));

        return ListView(
          children: result
              .map((e) => ListTile(
                    leading: Icon(Icons.history),
                    title: Text(e.name),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        searchBloc.add(DeleteSuggestionsEvent(e.id));
                      },
                    ),
                    onTap: () {
                      query = e.name;
                      showResults(context);
                    },
                  ))
              .toList(),
        );
      } else if (state is ErrorSearchState) {
        return ErrorPage(event: state.event, bloc: searchBloc);
      }
      return ErrorPage(event: SetInitialSearchEvent(), bloc: searchBloc);
    });
  }

  bool validate(String value) {
    String p = "/^\s/";
    RegExp regExp = new RegExp(p);
    if (regExp.hasMatch(value)) {
      return true;
    }
    return false;
  }
}
