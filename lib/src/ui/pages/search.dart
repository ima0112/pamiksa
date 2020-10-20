import 'package:flutter/material.dart';
import 'package:pamiksa/src/data/models/models.dart';
import 'package:pamiksa/src/ui/pages/pages.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => new _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  MySearchDelegate _delegate;

  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );

  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = new TextEditingController();
  List<String> _list;
  bool _IsSearching;
  String _searchText = "";
  String selectedSearchValue = "";

  _SearchListState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _IsSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _IsSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _IsSearching = false;
    createSearchResultList();
    _delegate =
        MySearchDelegate(words: _list, textInputType: TextInputType.text);
  }

  void createSearchResultList() {
    _list = <String>[
      "Pizza",
      "Pan con jamon",
      "Pan con queso",
      "Spaghettis",
      "Pan con pasta",
      "Pan con croqueta",
      "Pan con hamburguesa",
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: key,
      appBar: buildBar(context),
      body: ListView(
        children: <Widget>[
          new Text("Hello World!"),
          new Text("Hello World!"),
          new Text("Hello World!"),
          new Text("Hello World!"),
          new Text("Hello World!"),
          new Text("Hello World!"),
          new Text("Hello World!"),
          new Text("Hello World!"),
          new Text("Hello World!"),
          new Text("Hello World!"),
          new Text("Hello World!"),
          new Text("Hello World!"),
          new Text("Hello World!"),
          displaySearchResults(),
        ],
      ),
    );
  }

  Widget displaySearchResults() {
    if (_IsSearching) {
      return new Align(alignment: Alignment.topCenter, child: searchList());
    } else {
      return new Align(alignment: Alignment.topCenter, child: new Container());
    }
  }

  ListView searchList() {
    List<SearchModel> results = _buildSearchList();
    return ListView.builder(
      itemCount: _buildSearchList().isEmpty == null ? 0 : results.length,
      itemBuilder: (context, int index) {
        return Container(
          decoration: new BoxDecoration(
              color: Colors.grey,
              border: new Border(
                  bottom: new BorderSide(color: Colors.grey, width: 0.5))),
          child: ListTile(
            onTap: () {},
            title: Text(results.elementAt(index).name,
                style: new TextStyle(
                    fontSize: 18.0,
                    color: Theme.of(context).textTheme.bodyText1.color)),
          ),
        );
      },
    );
  }

  List<SearchModel> _buildList() {
    return _list.map((result) => new SearchModel(name: result)).toList();
  }

  List<SearchModel> _buildSearchList() {
    if (_searchText.isEmpty) {
      return _list.map((result) => new SearchModel(name: result)).toList();
    } else {
      List<String> _searchList = List();
      for (int i = 0; i < _list.length; i++) {
        String result = _list.elementAt(i);
        if ((result).toLowerCase().contains(_searchText.toLowerCase())) {
          _searchList.add(result);
        }
      }
      return _searchList
          .map((result) => new SearchModel(name: result))
          .toList();
    }
  }

  Widget buildBar(BuildContext context) {
    return new AppBar(
      title: Text("Busca"),
      actions: <Widget>[
        new IconButton(
          icon: actionIcon,
          onPressed: () async {
            final String selected =
                await showSearch(context: context, delegate: _delegate);
          },
        ),
        // new IconButton(icon: new Icon(Icons.more),
        //  onPressed: _IsSearching ? _showDialog(context, _buildSearchList()) : _showDialog(context,_buildList())
        //  )
      ],
    );
  }

  void _handleSearchStart() {
    setState(() {
      showSearch(context: context, delegate: _delegate);
      // _IsSearching = true;
    });
  }
}
