import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pamiksa/src/data/storage/secure_storage.dart';

class GraphQLConfiguration {
  final SecureStorage storage = new SecureStorage();
  String authToken;

  String uuidFromObject(Object object) {
    if (object is Map<String, Object>) {
      final String typeName = object['__typename'] as String;
      final String id = object['id'].toString();
      if (typeName != null && id != null) {
        return <String>[typeName, id].join('/');
      }
    }
    return null;
  }

  GraphQLClient clients() {
    final HttpLink httplink = HttpLink(
        uri: DotEnv().env['API_ADRESS'],
        headers: {'AccessToken': 'danielenriquearmasjuarez'});

    final PersistedQueriesLink _apqLink = PersistedQueriesLink(
      // To enable GET queries for the first load to allow for CDN caching
      useGETForHashedQueries: true,
    );

    final Link link1 = _apqLink.concat(httplink);

    final AuthLink authLink = AuthLink(
        getToken: () async => 'Bearer ${await storage.read(key: "authToken")}');

    final Link link = authLink.concat(link1);

    return GraphQLClient(
        cache: OptimisticCache(dataIdFromObject: uuidFromObject), link: link);
  }
}
