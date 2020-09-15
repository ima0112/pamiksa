import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseConnection {
  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'database.db');
    var database =
        await openDatabase(path, version: 3, onCreate: _onCreatingDatabase);
    return database;
  }

  _onCreatingDatabase(Database database, int version) async {
    await database.execute(
        'CREATE TABLE "Business" (id character varying(255) NOT NULL, name character varying(255),description character varying(255),adress character varying(255),phone character varying(255),email character varying(255),photo character varying(255),"valorationsQuantity" bigint,"valorationSum" double precision, valoration double precision,"deliveryPrice" double precision,CONSTRAINT "Business_pkey" PRIMARY KEY (id))');
    await database.execute(
        'CREATE TABLE "Provinces"(id character varying(255) NOT NULL,name character varying(255) NOT NULL,CONSTRAINT "Provinces_pkey" PRIMARY KEY (id),CONSTRAINT "Provinces_name_key" UNIQUE (name))');
    await database.execute(
        'CREATE TABLE "Municipalities"(id character varying(255) NOT NULL,name character varying(255),"provinceFk" character varying(255) NOT NULL,CONSTRAINT "Municipalities_pkey" PRIMARY KEY (id))');
  }
}
