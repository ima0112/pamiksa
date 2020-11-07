import 'package:flutter/material.dart';

class SuggestionPage extends StatelessWidget {
  final List suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  const SuggestionPage({Key key, this.suggestions, this.query, this.onSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final String suggestion = suggestions[index];
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
            onSelected(suggestion);
          },
        );
      },
    );
  }
}
