import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pamiksa/src/data/graphql/queries/queries.dart' as queries;
import 'package:pamiksa/src/data/graphql/mutations/mutations.dart' as mutations;
import 'package:pamiksa/src/data/models/favorite.dart';
import 'package:pamiksa/src/data/repositories/database_connection.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteRepository {
  final GraphQLClient client;
  final DatabaseConnection _databaseConnection = DatabaseConnection();
  static Database _database;

  FavoriteRepository({@required this.client}) : assert(client != null);

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
        .transaction((txn) async => txn.execute('DELETE FROM "Favorite"'));
  }

//Get all records
/*Future<List<Map>> all() async {
    var connection = await database;
    return await connection.transaction(
        (txn) async => await txn.rawQuery('SELECT * FROM "Business"'));
  }*/

  Future<QueryResult> fetchFavorite() async {
    final WatchQueryOptions _options = WatchQueryOptions(
      documentNode: gql(queries.favorite),
      fetchPolicy: FetchPolicy.networkOnly,
      fetchResults: true,
    );
    return await client.query(_options);
  }

  Future<QueryResult> createFavorite(String foodFk) async {
    final MutationOptions _options = MutationOptions(
      documentNode: gql(mutations.createFavorite),
      update: (Cache cache, QueryResult result) {
        return cache;
      },
      fetchPolicy: FetchPolicy.networkOnly,
      onCompleted: (data) {},
      variables: {
        'foodFk': foodFk,
      },
    );
    return await client.mutate(_options);
  }

  Future<QueryResult> deleteFavorite(String foodFk) async {
    final MutationOptions _options = MutationOptions(
      documentNode: gql(mutations.deleteFavorite),
      fetchPolicy: FetchPolicy.networkOnly,
      update: (Cache cache, QueryResult result) {
        return cache;
      },
      onCompleted: (data) {},
      variables: {
        'foodFk': foodFk,
      },
    );
    return await client.mutate(_options);
  }

  Future<QueryResult> favoriteFoodsById(String foodId) async {
    final WatchQueryOptions _options = WatchQueryOptions(
      fetchPolicy: FetchPolicy.cacheAndNetwork,
      documentNode: gql(queries.foodsById),
      variables: {'foodFk': foodId},
      fetchResults: true,
    );
    return await client.query(_options);
  }

  Future<FavoriteModel> getFavoriteFoodById(String id) async {
    FavoriteModel favoriteModel = FavoriteModel();
    var connection = await database;
    List<Map<dynamic, dynamic>> maps = await connection.transaction(
        (txn) async =>
            await txn.query("Favorite", where: 'id = ?', whereArgs: [id]));
    if (maps.length > 0) {
      favoriteModel.fromMap(maps.first);
      return favoriteModel;
    }
    return null;
  }
}
