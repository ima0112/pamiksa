import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:graphql/client.dart';
import 'package:pamiksa/src/data/graphql/queries/queries.dart' as queries;

class ProvincesRepository {
  final GraphQLClient client;

  ProvincesRepository({@required this.client}) : assert(client != null);

  Future<QueryResult> userLocation() async {
    final WatchQueryOptions _options = WatchQueryOptions(
      documentNode: gql(queries.userLocation),
      fetchResults: true,
    );

    return await client.query(_options);
  }
}
