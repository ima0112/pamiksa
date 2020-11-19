import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/blocs.dart';
import 'package:pamiksa/src/blocs/search_details/search_details_bloc.dart';
import 'package:pamiksa/src/data/models/models.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';

class FoodSearch extends SearchDelegate<SearchModel> {
  final NavigationService navigationService = locator<NavigationService>();

  SearchBloc searchBloc;
  SearchDetailsBloc searchDetailsBloc;

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      if (query.isNotEmpty)
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          },
        )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        color: Theme.of(context).iconTheme.color,
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    searchDetailsBloc = BlocProvider.of<SearchDetailsBloc>(context);
    searchBloc = BlocProvider.of<SearchBloc>(context);
    searchBloc.add(SearchFoodEvent(query));

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
        } else if (state is SearchConnectionFailedState) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [Text("Tienes un problema con la conexion")],
              ),
            ),
          );
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
            return Align(
              alignment: Alignment.topCenter,
              child: LinearProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: state.searchModel.length,
            itemBuilder: (context, index) {
              final String result = state.searchModel[index].name;
              return ListTile(
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
        return Align(
          alignment: Alignment.topCenter,
          child: LinearProgressIndicator(),
        );
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
                    onTap: () {},
                  ))
              .toList(),
        );
      }
      return Container();
    });
  }
}
