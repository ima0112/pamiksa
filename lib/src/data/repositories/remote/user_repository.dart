import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pamiksa/src/data/graphql/queries/queries.dart' as queries;
import 'package:pamiksa/src/data/graphql/mutations/mutations.dart' as mutations;
import 'package:pamiksa/src/data/models/device.dart';
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
      onCompleted: (data) {
        preferences.saveString('token', data['signUp']['token'].toString());
        preferences.saveString(
            'refreshToken', data['signUp']['refreshToken'].toString());
      },
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
    return await client.mutate(_options);
  }

  Future<QueryResult> signIn(
      String email, String password, DeviceModel deviceModel) async {
    final MutationOptions _options = MutationOptions(
      documentNode: gql(mutations.singIn),
      onCompleted: (data) {
        preferences.saveString('token', data['signIn']['token'].toString());
        preferences.saveString(
            'refreshToken', data['signIn']['refreshToken'].toString());
      },
      variables: {
        'email': email,
        'password': password,
        'plattform': deviceModel.platform,
        'systemVersion': deviceModel.systemVersion,
        'deviceId': deviceModel.deviceId,
        'model': deviceModel.model
      },
    );
    return await client.mutate(_options);
  }

  Future<QueryResult> sendVerificationCode(String code, String email) async {
    final MutationOptions _options = MutationOptions(
        documentNode: gql(mutations.sendVerificationCode),
        variables: {'code': code, 'email': email});
    return await client.mutate(_options);
  }
}
