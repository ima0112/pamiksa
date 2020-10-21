import 'package:flutter/material.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';
import 'package:pamiksa/src/ui/pages/pages.dart';

class MySearchDelegate extends SearchDelegate<String> {
  final List<String> _words;
  final List<String> _history;
  final NavigationService navigationService = locator<NavigationService>();

  MySearchDelegate({List<String> words, TextInputType textInputType})
      : _words = words,
        _history = <String>["Pizza", "Pan con jamon"],
        super();

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        primaryColor: Theme.of(context).appBarTheme.color);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      query.isEmpty
          ? IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                null;
              },
            )
          : IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                query = '';
                showSuggestions(context);
              })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        color: Theme.of(context).iconTheme.color,
        onPressed: () {
          navigationService.navigateAndRemove(Routes.HomeRoute);
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
    final Iterable<String> suggestions = this.query.isEmpty
        ? _history
        : _words.where((element) => element.startsWith(query));

    return SuggestionPage(
      query: this.query,
      suggestions: suggestions.toList(),
      onSelected: (value) {
        this.query = value;
        this._history.insert(0, value);
        showResults(context);
      },
    );
  }
}
