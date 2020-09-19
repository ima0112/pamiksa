import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfiguration {
  GraphQLClient clients() {
    final HttpLink httplink = HttpLink(
        uri: 'http://192.168.0.2:8000/graphql/',
        headers: {'AccessToken': 'danielenriquearmasjuarez'});

    final String authToken = "";

    final AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer $authToken',
    );
    final Link link = authLink.concat(httplink);

    return GraphQLClient(cache: InMemoryCache(), link: link);
  }
}
