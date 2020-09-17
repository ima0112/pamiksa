import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pamiksa/src/data/shared/shared.dart';
import 'package:pamiksa/src/data/graphql/queries/queries.dart' as queries;

class RegisterDataRepository {
  final GraphQLClient client;
  Shared preferences = Shared();

  RegisterDataRepository({@required this.client}) : assert(client != null);

  Future<QueryResult> registerData() async {
    final WatchQueryOptions _options = WatchQueryOptions(
      documentNode: gql(queries.register_data),
      fetchResults: true,
    );
    return await client.query(_options);
  }
}
