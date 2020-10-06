import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfiguration {
  final storage = new FlutterSecureStorage();
  String authToken;

  GraphQLClient clients() {
    final HttpLink httplink = HttpLink(
        uri: 'http://192.168.0.50:8000/graphql/',
        headers: {'AccessToken': 'danielenriquearmasjuarez'});

    final AuthLink authLink = AuthLink(
        getToken: () async => 'Bearer ${await storage.read(key: "authToken")}');
    final Link link = authLink.concat(httplink);

    return GraphQLClient(cache: InMemoryCache(), link: link);
  }
}
