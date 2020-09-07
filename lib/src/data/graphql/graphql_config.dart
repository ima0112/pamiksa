import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfiguration {
  static HttpLink httplink = HttpLink(
      uri: 'http://192.168.0.2:8000/graphql/',
      headers: {'AccessToken': 'danielenriquearmasjuarez'});

//  final AuthLink authLink = AuthLink(
//    getToken: () async => 'Bearer ',
//  );
//  final Link link = authLink.concat(httplink);
  static ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(cache: InMemoryCache(), link: httplink));

  GraphQLClient clients() {
    final HttpLink httplink = HttpLink(
        uri: 'http://192.168.0.2:8000/graphql/',
        headers: {'AccessToken': 'danielenriquearmasjuarez'});

//  final AuthLink authLink = AuthLink(
//    getToken: () async => 'Bearer ',
//  );
//  final Link link = authLink.concat(httplink);
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
        GraphQLClient(cache: InMemoryCache(), link: httplink));

    return GraphQLClient(cache: InMemoryCache(), link: httplink);
  }
}
