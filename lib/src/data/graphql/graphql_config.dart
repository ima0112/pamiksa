import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfiguration {
  GraphQLClient clients() {
    final HttpLink httplink = HttpLink(
        uri: 'http://192.168.0.2:8000/graphql/',
        headers: {'AccessToken': 'danielenriquearmasjuarez'});

//  final AuthLink authLink = AuthLink(
//    getToken: () async => 'Bearer ',
//  );
//  final Link link = authLink.concat(httplink);

    return GraphQLClient(cache: InMemoryCache(), link: httplink);
  }
}
