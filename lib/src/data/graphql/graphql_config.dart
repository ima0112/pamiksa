import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pamiksa/src/data/storage/secure_storage.dart';

class GraphQLConfiguration {
  final SecureStorage storage = new SecureStorage();
  String authToken;

  GraphQLClient clients() {
    final HttpLink httplink = HttpLink(
        uri: DotEnv().env['API_ADRESS'],
        headers: {'AccessToken': 'danielenriquearmasjuarez'});

    final AuthLink authLink = AuthLink(
        getToken: () async => 'Bearer ${await storage.read(key: "authToken")}');
    final Link link = authLink.concat(httplink);

    return GraphQLClient(cache: InMemoryCache(), link: link);
  }
}
