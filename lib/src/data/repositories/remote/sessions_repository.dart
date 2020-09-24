import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pamiksa/src/data/graphql/queries/queries.dart' as queries;
import 'package:pamiksa/src/data/graphql/mutations/mutations.dart' as mutations;
import 'package:pamiksa/src/data/repositories/database_connection.dart';
import 'package:sqflite/sqflite.dart';

class SessionsRepository {
  final GraphQLClient client;
  final DatabaseConnection _databaseConnection = DatabaseConnection();
  static Database _database;

  SessionsRepository({@required this.client}) : assert(client != null);

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _databaseConnection.setDatabase();
    return _database;
  }

  Future<QueryResult> fetchSessions(String deviceId) async {
    final WatchQueryOptions _options = WatchQueryOptions(
      documentNode: gql(queries.devicesByUser),
      fetchPolicy: FetchPolicy.cacheAndNetwork,
      fetchResults: true,
      variables: {
        'deviceId': deviceId,
      },
    );
    return await client.query(_options);
  }

  Future<QueryResult> signOutAll(String deviceId) async {
    final MutationOptions _options = MutationOptions(
      documentNode: gql(mutations.signOutAll),
      variables: {
        'deviceId': deviceId,
      },
    );
    return await client.mutate(_options);
  }

  //Insert data to Table
  insert(data) async {
    var connection = await database;
    return await connection
        .transaction((txn) async => txn.insert("Sessions", data));
  }

  deleteById(String id) async {
    var connection = await database;
    return await connection.transaction((txn) async => txn.delete("Sessions", where: '"deviceId" = ?', whereArgs: [id]));
  }

  //Clear database
  clear() async {
    var connection = await database;
    await connection
        .transaction((txn) async => txn.execute('DELETE FROM "Sessions"'));
  }
}
