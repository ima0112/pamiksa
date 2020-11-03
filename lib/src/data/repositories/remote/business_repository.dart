import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pamiksa/src/data/graphql/queries/queries.dart' as queries;
import 'package:pamiksa/src/data/models/models.dart';
import 'package:pamiksa/src/data/repositories/database_connection.dart';
import 'package:sqflite/sqflite.dart';

class BusinessRepository {
  final GraphQLClient client;
  final DatabaseConnection _databaseConnection = DatabaseConnection();
  static Database _database;

  BusinessRepository({@required this.client}) : assert(client != null);

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _databaseConnection.setDatabase();
    return _database;
  }

  Future<QueryResult> fetchBusiness() async {
    final WatchQueryOptions _options = WatchQueryOptions(
      fetchPolicy: FetchPolicy.cacheAndNetwork,
      documentNode: gql(queries.business),
      fetchResults: true,
    );
    return await client.query(_options);
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
        .transaction((txn) async => txn.execute('DELETE FROM "Business"'));
  }
//Get all records
/*Future<List<Map>> all() async {
    var connection = await database;
    return await connection.transaction(
        (txn) async => await txn.rawQuery('SELECT * FROM "Business"'));
  }*/

  Future<BusinessModel> getById(String id) async {
    BusinessModel businessModel = BusinessModel();
    var connection = await database;
    List<Map<dynamic, dynamic>> maps = await connection.transaction(
        (txn) async =>
            await txn.query("Business", where: 'id = ?', whereArgs: [id]));
    if (maps.length > 0) {
      businessModel.fromMap(maps.first);
      return businessModel;
    }
    return null;
  }
}
