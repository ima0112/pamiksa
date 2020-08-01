import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfiguration {
  static HttpLink httplink = HttpLink(
      uri: 'http://10.0.2.2:8000/graphql/',
      headers: {'AccessToken': '12345678'});

//  final AuthLink authLink = AuthLink(
//    getToken: () async => 'Bearer ',
//  );
//  final Link link = authLink.concat(httplink);
  ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(cache: InMemoryCache(), link: httplink));

  GraphQLClient clientToQuery() {
    return GraphQLClient(cache: InMemoryCache(), link: httplink);
  }
}
