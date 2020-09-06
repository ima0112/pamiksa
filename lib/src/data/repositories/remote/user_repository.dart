import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:gql/language.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pamiksa/src/data/graphql/queries/queries.dart' as queries;
import 'package:pamiksa/src/data/graphql/mutations/mutations.dart' as mutations;
import 'package:pamiksa/src/data/models/user.dart';
import 'package:pamiksa/src/data/shared/shared.dart';

class UserRepository {
  final GraphQLClient client;
  Shared preferences = Shared();

  UserRepository({@required this.client}) : assert(client != null);

  Future<QueryResult> userExists(String email) async {
    final WatchQueryOptions _options = WatchQueryOptions(
      documentNode: gql(queries.userExists),
      variables: {'email': email},
      fetchResults: true,
    );

    return await client.query(_options);
  }

  Future<QueryResult> signUp(UserModel userModel) async {
    final MutationOptions _options = MutationOptions(
      documentNode: gql(mutations.signUp),
      // onCompleted: (data) {
      //   print(data['signUp']['token']);
      // },
      variables: {
        'fullName': userModel.fullName,
        'email': userModel.email,
        'password': userModel.password,
        'birthday': userModel.birthday,
        'adress': userModel.adress,
        'provinceFk': 1,
        'municipalityFk': 1
      },
    );
    final result = await client.mutate(_options);
    print(result.data.toString());
    return result;
  }
}
