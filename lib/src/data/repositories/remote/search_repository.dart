import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pamiksa/src/data/graphql/queries/queries.dart' as queries;

class SearchRepository {
  final GraphQLClient client;

  SearchRepository({@required this.client}) : assert(client != null);

  Future<QueryResult> foods(String name) async {
    final WatchQueryOptions _options = WatchQueryOptions(
      fetchPolicy: FetchPolicy.cacheAndNetwork,
      documentNode: gql(queries.sarch),
      variables: {'name': name},
      fetchResults: true,
    );
    return await client.query(_options);
  }
}
