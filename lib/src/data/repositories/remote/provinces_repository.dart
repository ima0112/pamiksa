import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:gql/language.dart';
import 'package:graphql/client.dart';
import 'package:pamiksa/src/data/graphql/queries/queries.dart' as queries;
import 'package:pamiksa/src/data/graphql/mutations/mutations.dart' as mutations;

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

  // Future<QueryResult> toggleRepoStar(Repo repo) async {
  //   var document =
  //       repo.viewerHasStarred ? mutations.removeStar : mutations.addStar;

  //   final MutationOptions _options = MutationOptions(
  //     documentNode: parseString(document),
  //     variables: <String, String>{
  //       'starrableId': repo.id,
  //     },
  //   );

  //   return await client.mutate(_options);
  // }
}
