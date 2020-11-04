import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pamiksa/src/data/repositories/database_connection.dart';
import 'package:pamiksa/src/data/graphql/queries/queries.dart' as queries;
import 'package:sqflite/sqflite.dart';

class AddonsRepository {
  final GraphQLClient client;
  final DatabaseConnection _databaseConnection = DatabaseConnection();
  static Database _database;

  AddonsRepository({@required this.client}) : assert(client != null);

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _databaseConnection.setDatabase();
    return _database;
  }

  //Insert data to Table
  insert(table, data) async {
    var connection = await database;
    return await connection.transaction((txn) async => txn.insert(table, data));
  }

  //Clear database
  clear() async {
    var connection = await database;
    await connection
        .transaction((txn) async => txn.execute('DELETE FROM "Addons"'));
  }

//Get all records
/*Future<List<Map>> all() async {
    var connection = await database;
    return await connection.transaction(
        (txn) async => await txn.rawQuery('SELECT * FROM "Business"'));
  }*/

  Future<QueryResult> addons(String id) async {
    final WatchQueryOptions _options = WatchQueryOptions(
      documentNode: gql(queries.addons),
      variables: {'foodFk': id},
      fetchResults: true,
    );
    return await client.query(_options);
  }
}
