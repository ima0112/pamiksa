import 'package:flutter/widgets.dart';
import 'package:graphql/client.dart';
import 'package:pamiksa/src/data/graphql/queries/queries.dart' as queries;
import 'package:pamiksa/src/data/models/province.dart';
import 'package:pamiksa/src/data/repositories/database_connection.dart';
import 'package:sqflite/sqflite.dart';

class ProvinceRepository {
  final GraphQLClient client;
  final DatabaseConnection _databaseConnection = DatabaseConnection();
  static Database _database;

  List<ProvinceModel> provinceModel;

  ProvinceRepository({@required this.client}) : assert(client != null);

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
        .transaction((txn) async => txn.insert("Provinces", data));
  }

  //Clear database
  clear() async {
    var connection = await database;
    await connection
        .transaction((txn) async => txn.execute('DELETE FROM "Provinces"'));
  }

  //Get all records
  Future<List<Map>> all() async {
    var connection = await database;
    return await connection.transaction(
        (txn) async => await txn.rawQuery('SELECT * FROM "Provinces"'));
  }
}
