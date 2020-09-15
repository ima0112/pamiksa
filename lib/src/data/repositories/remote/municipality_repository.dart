import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pamiksa/src/data/models/municipality.dart';
import 'package:pamiksa/src/data/repositories/database_connection.dart';
import 'package:sqflite/sqflite.dart';
import 'package:pamiksa/src/data/graphql/queries/queries.dart' as queries;

class MunicipalityRepository {
  final GraphQLClient client;
  final DatabaseConnection _databaseConnection = DatabaseConnection();
  static Database _database;

  List<MunicipalityModel> provinceModel;

  MunicipalityRepository({@required this.client}) : assert(client != null);

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _databaseConnection.setDatabase();
    return _database;
  }

  Future<QueryResult> userLocation() async {
    final WatchQueryOptions _options = WatchQueryOptions(
      documentNode: gql(queries.userLocation),
      fetchResults: true,
    );
    return await client.query(_options);
  }

  // insertTodo(Todo todo) async {
  //   final db = await database;
  //   var res = await db.insert(Todo.TABLENAME, todo.toMap(),
  //       conflictAlgorithm: ConflictAlgorithm.replace);
  //   return res;
  // }

  //Insert data to Table
  insert(data) async {
    var connection = await database;
    return await connection
        .transaction((txn) async => txn.insert("Municipalities", data));
  }

  //Clear database
  clear() async {
    var connection = await database;
    await connection.transaction(
        (txn) async => txn.execute('DELETE FROM "Municipalities"'));
  }

  //Get all records
  Future<List<Map>> all() async {
    var connection = await database;
    return await connection.transaction(
        (txn) async => await txn.rawQuery('SELECT * FROM "Municipalities"'));
  }
}
