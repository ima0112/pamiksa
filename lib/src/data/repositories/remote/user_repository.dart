import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:graphql/client.dart';
import 'package:package_info/package_info.dart';
import 'package:pamiksa/src/data/models/models.dart';
import 'package:pamiksa/src/data/repositories/database_connection.dart';
import 'package:pamiksa/src/data/storage/secure_storage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pamiksa/src/data/graphql/queries/queries.dart' as queries;
import 'package:pamiksa/src/data/graphql/mutations/mutations.dart' as mutations;
import 'package:pamiksa/src/data/device_info.dart' as deviceInfo;

class UserRepository {
  final GraphQLClient client;
  final DatabaseConnection _databaseConnection = DatabaseConnection();
  static Database _database;

  DeviceModel deviceModel = DeviceModel();
  SecureStorage secureStorage = SecureStorage();

  UserRepository({@required this.client}) : assert(client != null);

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _databaseConnection.setDatabase();
    return _database;
  }

  Future<QueryResult> userExists(String email) async {
    final WatchQueryOptions _options = WatchQueryOptions(
      documentNode: gql(queries.userExists),
      variables: {'email': email},
      fetchResults: true,
    );
    return await client.query(_options);
  }

  Future<QueryResult> me() async {
    final WatchQueryOptions _options = WatchQueryOptions(
      documentNode: gql(queries.me),
      fetchPolicy: FetchPolicy.cacheAndNetwork,
      fetchResults: true,
    );
    return await client.query(_options);
  }

  Future<QueryResult> editProfile(String photo) async {
    final MutationOptions _options = MutationOptions(
      documentNode: gql(mutations.editProfile),
      variables: {'photo': photo},
    );
    return await client.mutate(_options);
  }

  Future<QueryResult> refreshToken(String refreshToken) async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    //double currentVersion = double.parse(info.version.trim().replaceAll(".", ""));
    String currentVersion = info.version;
    final MutationOptions _options = MutationOptions(
      documentNode: gql(mutations.refreshToken),
      onCompleted: (data) {
        if (data != null) {
          secureStorage.save(
              key: "authToken",
              value: data['refreshTheToken']['token'].toString());
          secureStorage.save(
              key: "refreshToken",
              value: data['refreshTheToken']['refreshToken'].toString());
        }
      },
      variables: {
        'refreshTokenValue': refreshToken,
        'appVersion': currentVersion,
      },
    );
    return await client.mutate(_options);
  }

  Future<QueryResult> signUp(
      UserModel userModel, DeviceModel deviceModel) async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    //double currentVersion = double.parse(info.version.trim().replaceAll(".", ""));
    String currentVersion = info.version;
    final MutationOptions _options = MutationOptions(
      documentNode: gql(mutations.signUp),
      onCompleted: (data) {
        if (data != null) {
          secureStorage.save(
              key: "authToken", value: data['signUp']['token'].toString());
          secureStorage.save(
              key: "refreshToken",
              value: data['signUp']['refreshToken'].toString());
        }
      },
      variables: {
        'fullName': userModel.fullName,
        'email': userModel.email,
        'password': userModel.password,
        'birthday': userModel.birthday,
        'adress': userModel.adress,
        'provinceFk': userModel.province,
        'municipalityFk': userModel.municipality,
        'appVersion': currentVersion,
        'platform': deviceModel.platform,
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
    final PackageInfo info = await PackageInfo.fromPlatform();
    //double currentVersion = double.parse(info.version.trim().replaceAll(".", ""));
    String currentVersion = info.version;
    final MutationOptions _options = MutationOptions(
      documentNode: gql(mutations.singIn),
      onCompleted: (data) {
        if (data != null) {
          secureStorage.save(
              key: "authToken", value: data['signIn']['token'].toString());
          secureStorage.save(
              key: "refreshToken",
              value: data['signIn']['refreshToken'].toString());
        }
      },
      variables: {
        'email': email,
        'password': password,
        'appVersion': currentVersion,
        'platform': deviceModel.platform,
        'systemVersion': deviceModel.systemVersion,
        'deviceId': deviceModel.deviceId,
        'model': deviceModel.model,
        'app': "pamiksa"
      },
    );
    return await client.mutate(_options);
  }

  Future<QueryResult> resetPassword(
      String email, String password, DeviceModel deviceModel) async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    //double currentVersion = double.parse(info.version.trim().replaceAll(".", ""));
    String currentVersion = info.version;
    final MutationOptions _options = MutationOptions(
      documentNode: gql(mutations.resetPassword),
      onCompleted: (data) {
        secureStorage.save(
            key: "authToken", value: data['resetPassword']['token'].toString());
        secureStorage.save(
            key: "refreshToken",
            value: data['resetPassword']['refreshToken'].toString());
      },
      variables: {
        'email': email,
        'password': password,
        'platform': deviceModel.platform,
        'systemVersion': deviceModel.systemVersion,
        'deviceId': deviceModel.deviceId,
        'model': deviceModel.model,
        'app': 'pamiksa',
        'appVersion': currentVersion
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

  Future<QueryResult> changePassword(String password) async {
    final MutationOptions _options = MutationOptions(
        documentNode: gql(mutations.changePassword),
        variables: {'password': password});
    return await client.mutate(_options);
  }

  Future<QueryResult> checkSession(String deviceId) async {
    DeviceModel deviceModel = DeviceModel();
    await deviceInfo.initPlatformState(deviceModel);
    final PackageInfo info = await PackageInfo.fromPlatform();
    //double currentVersion = double.parse(info.version.trim().replaceAll(".", ""));
    String currentVersion = info.version;
    final WatchQueryOptions _options = WatchQueryOptions(
      documentNode: gql(queries.checkSession),
      variables: {
        'deviceId': deviceId,
        'appVersion': currentVersion,
        'systemVersion': deviceModel.systemVersion,
        'refreshToken': await secureStorage.read(key: 'refreshToken')
      },
      fetchResults: true,
    );
    return await client.query(_options);
  }

  Future<QueryResult> editName(String fullName) async {
    final MutationOptions _options = MutationOptions(
        documentNode: gql(mutations.editProfile),
        variables: {'fullName': fullName});
    return await client.mutate(_options);
  }

  Future<QueryResult> editAdress(String adress) async {
    final MutationOptions _options = MutationOptions(
        documentNode: gql(mutations.editProfile),
        variables: {'adress': adress});
    return await client.mutate(_options);
  }

  Future<QueryResult> editEmail(String email) async {
    final MutationOptions _options = MutationOptions(
        documentNode: gql(mutations.editProfile), variables: {'email': email});
    return await client.mutate(_options);
  }

  //Insert data to Table
  insert(data) async {
    var connection = await database;
    return await connection
        .transaction((txn) async => txn.insert("Users", data));
  }

  //Clear database
  clear() async {
    var connection = await database;
    await connection
        .transaction((txn) async => txn.execute('DELETE FROM "Users"'));
  }

  //Get all records
  Future<List<Map>> all() async {
    var connection = await database;
    return await connection.transaction(
        (txn) async => await txn.rawQuery('SELECT * FROM "Users" LIMIT 1'));
  }
}
