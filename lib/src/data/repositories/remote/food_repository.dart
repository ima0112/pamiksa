import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pamiksa/src/data/graphql/queries/queries.dart' as queries;

class FoodRepository {
  final GraphQLClient client;

  FoodRepository({@required this.client}) : assert(client != null);

  Future<QueryResult> foods(String businessId) async {
    final WatchQueryOptions _options = WatchQueryOptions(
      documentNode: gql(queries.foods),
      variables: {'businessFk': businessId},
      fetchResults: true,
    );
    return await client.query(_options);
  }
}
