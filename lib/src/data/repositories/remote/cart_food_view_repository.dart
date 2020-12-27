import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pamiksa/src/data/repositories/database_connection.dart';
import 'package:sqflite/sqflite.dart';

class CartFoodViewRepository {
  final GraphQLClient client;
  final DatabaseConnection _databaseConnection = DatabaseConnection();
  static Database _database;

  CartFoodViewRepository({@required this.client}) : assert(client != null);

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
        .transaction((txn) async => txn.execute('DELETE FROM "CartFoodView"'));
  }

  //Update row in Table
  updateById(String id, int isFavorite) async {
    // row to update
    Map<String, dynamic> row = {
      'isFavorite': isFavorite,
    };
    var connection = await database;
    await connection.transaction((txn) async =>
        txn.update('CartFoodView', row, where: 'id = ?', whereArgs: [id]));
  }

//Get all records
  Future<List<Map>> all() async {
    var connection = await database;
    return await connection.transaction(
        (txn) async => await txn.rawQuery('SELECT * FROM "CartFoodView"'));
  }

  // Future<QueryResult> foodsById(String foodId) async {
  //   final WatchQueryOptions _options = WatchQueryOptions(
  //     fetchPolicy: FetchPolicy.cacheAndNetwork,
  //     documentNode: gql(queries.foodsById),
  //     variables: {'foodFk': foodId},
  //     fetchResults: true,
  //   );
  //   return await client.query(_options);
  // }

  // Future<FoodModel> getById(String id) async {
  //   FoodModel foodModel = FoodModel();
  //   var connection = await database;
  //   List<Map<dynamic, dynamic>> maps = await connection.transaction(
  //       (txn) async =>
  //           await txn.query("Food", where: 'id = ?', whereArgs: [id]));
  //   if (maps.length > 0) {
  //     foodModel.fromMap(maps.first);
  //     return foodModel;
  //   }
  //   return null;
  // }
}
