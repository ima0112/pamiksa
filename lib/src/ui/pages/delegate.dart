import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/blocs.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';
import 'package:pamiksa/src/ui/pages/pages.dart';

class MySearchDelegate extends SearchDelegate<String> {
  final List<String> _history;
  final NavigationService navigationService = locator<NavigationService>();

  SearchBloc searchBloc;
  FoodBloc foodBloc;

  MySearchDelegate()
      : _history = List(),
        super();

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
        brightness: Theme.of(context).brightness,
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        primaryColor: Theme.of(context).appBarTheme.color);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    searchBloc = BlocProvider.of<SearchBloc>(context);
    return <Widget>[
      query.isEmpty
          // ignore: missing_required_param
          ? IconButton(
              icon: Icon(Icons.search),
            )
          : IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                searchBloc.add(SearchFoodEvent(query));
              },
            )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        color: Theme.of(context).iconTheme.color,
        onPressed: () {
          navigationService.goBack();
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Text("Seleccionaste: ${this.query}")],
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    Iterable<String> suggestions = _history;

    // if(this.query.isEmpty){
    //   suggestions = _history;
    // }else{
    //   suggestions = async
    // }
    //  ? _history : ()async{
    //   await

    // };
// _words.where((element) => element.toLowerCase().contains(query));

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        searchBloc = BlocProvider.of<SearchBloc>(context);
        if (state is SearchInitial) {
          return ListView.builder(
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              final String suggestion = suggestions.toList()[index];
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
                onTap: () {},
              );
            },
          );
          // onSelected: (value) {
          //   this.query = value;
          //   this._history.insert(0, value);
          //   showResults(context);
          // },

        } else if (state is FoodsFoundState) {
          foodBloc = BlocProvider.of<FoodBloc>(context);
          return ListView.builder(
            itemCount: state.searchModel.length,
            itemBuilder: (context, index) {
              final String suggestion = state.searchModel[index].name;
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
                  foodBloc.add(FetchFoodEvent(state.searchModel[index].id));
                  navigationService.navigateTo(Routes.FoodRoute);
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
}
