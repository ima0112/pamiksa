import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pamiksa/src/data/graphql/queries/queries.dart' as queries;
import 'package:pamiksa/src/data/graphql/mutations/mutations.dart' as mutations;
import 'package:pamiksa/src/data/models/food.dart';
import 'package:pamiksa/src/data/repositories/database_connection.dart';
import 'package:sqflite/sqflite.dart';

class FoodRepository {
  final GraphQLClient client;
  final DatabaseConnection _databaseConnection = DatabaseConnection();
  static Database _database;

  FoodRepository({@required this.client}) : assert(client != null);

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
        .transaction((txn) async => txn.execute('DELETE FROM "Food"'));
  }

  //Update row in Table
  updateById(String id, int isFavorite) async {
    // row to update
    Map<String, dynamic> row = {
      'isFavorite': isFavorite,
    };
    var connection = await database;
    await connection.transaction((txn) async =>
        txn.update('Food', row, where: 'id = ?', whereArgs: [id]));
  }

//Get all records
  Future<List<Map>> all() async {
    var connection = await database;
    return await connection
        .transaction((txn) async => await txn.rawQuery('SELECT * FROM "Food"'));
  }

  Future<int> insertAll(List<dynamic> arguments) async {
    var connection = await database;
    return await connection.transaction((txn) async => await txn.rawInsert(
        'INSERT INTO "Food" (photoUrl, isAvailable, price, name, description, photo, id, availability, isFavorite)',
        arguments));
  }

  Future<QueryResult> foods(String businessId) async {
    final WatchQueryOptions _options = WatchQueryOptions(
      fetchPolicy: FetchPolicy.cacheAndNetwork,
      documentNode: gql(queries.foods),
      variables: {'businessFk': businessId},
      fetchResults: true,
    );
    return await client.query(_options);
  }

  Future<QueryResult> foodsById(String foodId) async {
    final WatchQueryOptions _options = WatchQueryOptions(
      fetchPolicy: FetchPolicy.cacheAndNetwork,
      documentNode: gql(queries.foodsById),
      variables: {'foodFk': foodId},
      fetchResults: true,
    );
    return await client.query(_options);
  }

  Future<FoodModel> getById(String id) async {
    FoodModel foodModel = FoodModel();
    var connection = await database;
    List<Map<dynamic, dynamic>> maps = await connection.transaction(
        (txn) async =>
            await txn.query("Food", where: 'id = ?', whereArgs: [id]));
    if (maps.length > 0) {
      foodModel.fromMap(maps.first);
      return foodModel;
    }
    return null;
  }
}
