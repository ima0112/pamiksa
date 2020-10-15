import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pamiksa/src/data/graphql/queries/queries.dart' as queries;
import 'package:pamiksa/src/data/graphql/mutations/mutations.dart' as mutations;
import 'package:pamiksa/src/data/device_info.dart' as deviceInfo;
import 'package:pamiksa/src/data/models/models.dart';

class UserRepository {
  final GraphQLClient client;
  DeviceModel deviceModel = DeviceModel();
  final secureStorage = new FlutterSecureStorage();

  UserRepository({@required this.client}) : assert(client != null);

  Future<QueryResult> userExists(String email) async {
    final WatchQueryOptions _options = WatchQueryOptions(
      documentNode: gql(queries.userExists),
      variables: {'email': email},
      fetchResults: true,
    );
    return await client.query(_options);
  }

  Future<QueryResult> signUp(
      UserModel userModel, DeviceModel deviceModel) async {
    final MutationOptions _options = MutationOptions(
      documentNode: gql(mutations.signUp),
      onCompleted: (data) {
        secureStorage.write(
            key: "authToken", value: data['signUp']['token'].toString());
        secureStorage.write(
            key: "refreshToken",
            value: data['signUp']['refreshToken'].toString());
      },
      variables: {
        'fullName': userModel.fullName,
        'email': userModel.email,
        'password': userModel.password,
        'birthday': userModel.birthday,
        'adress': userModel.adress,
        'provinceFk': userModel.province,
        'municipalityFk': userModel.municipality,
        'plattform': deviceModel.plattform,
        'systemVersion': deviceModel.systemVersion,
        'deviceId': deviceModel.deviceId,
        'model': deviceModel.model
      },
    );
    return await client.mutate(_options);
  }

  Future<QueryResult> signOut(String deviceId) async {
    final MutationOptions _options = MutationOptions(
      documentNode: gql(mutations.signOut),
      variables: {'deviceId': deviceId},
    );
    return await client.mutate(_options);
  }

  Future<QueryResult> signIn(
      String email, String password, DeviceModel deviceModel) async {
    final MutationOptions _options = MutationOptions(
      documentNode: gql(mutations.singIn),
      onCompleted: (data) {
        if (data != null) {
          secureStorage.write(
              key: "authToken", value: data['signIn']['token'].toString());
          secureStorage.write(
              key: "refreshToken",
              value: data['signIn']['refreshToken'].toString());
        }
      },
      variables: {
        'email': email,
        'password': password,
        'plattform': deviceModel.plattform,
        'systemVersion': deviceModel.systemVersion,
        'deviceId': deviceModel.deviceId,
        'model': deviceModel.model,
      },
    );
    return await client.mutate(_options);
  }

  Future<QueryResult> resetPassword(
      String email, String password, DeviceModel deviceModel) async {
    final MutationOptions _options = MutationOptions(
      documentNode: gql(mutations.resetPassword),
      onCompleted: (data) {
        secureStorage.write(
            key: "authToken", value: data['resetPassword']['token'].toString());
        secureStorage.write(
            key: "refreshToken",
            value: data['resetPassword']['refreshToken'].toString());
      },
      variables: {
        'email': email,
        'password': password,
        'plattform': deviceModel.plattform,
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
        variables: {'code': code, 'email': email, 'question': 'question'});
    return await client.mutate(_options);
  }

  Future<QueryResult> checkSession(String deviceId) async {
    final WatchQueryOptions _options = WatchQueryOptions(
      documentNode: gql(queries.checkSession),
      variables: {'deviceId': deviceId},
      fetchResults: true,
    );
    return await client.query(_options);
  }
}
