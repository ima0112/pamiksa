import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pamiksa/src/data/storage/secure_storage.dart';

class GraphQLConfiguration {
  final SecureStorage storage = new SecureStorage();
  String authToken;

  GraphQLClient clients() {
    final HttpLink httplink = HttpLink(
        uri: 'http://192.168.0.50:8000/graphql/',
        headers: {'AccessToken': 'danielenriquearmasjuarez'});

    final AuthLink authLink = AuthLink(
        getToken: () async => 'Bearer ${await storage.read("authToken")}');
    final Link link = authLink.concat(httplink);

    return GraphQLClient(cache: InMemoryCache(), link: link);
  }
}
