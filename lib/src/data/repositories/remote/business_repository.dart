import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pamiksa/src/data/graphql/queries/queries.dart' as queries;

class BusinessRepository {
  final GraphQLClient client;

  BusinessRepository({@required this.client}) : assert(client != null);

  Future<QueryResult> fetchBusiness() async {
    final WatchQueryOptions _options = WatchQueryOptions(
      documentNode: gql(queries.business),
      fetchResults: true,
    );
    return await client.query(_options);
  }
}
