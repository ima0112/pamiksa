import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseConnection {
  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'database.db');
    var database =
        await openDatabase(path, version: 1, onCreate: _onCreatingDatabase);
    return database;
  }

  _onCreatingDatabase(Database database, int version) async {
    await database.execute(
        'CREATE TABLE "Suggestion" (id integer PRIMARY KEY AUTOINCREMENT, name character varying(255))');
    await database.execute(
        'CREATE TABLE "Search" (id character varying(255) NOT NULL,name character varying(255) NOT NULL,description character varying(255),price double precision NOT NULL,photo character varying(255) NOT NULL,photoUrl character varying(255) NOT NULL,"isAvailable" boolean DEFAULT false,availability integer DEFAULT 0,CONSTRAINT "Food_pkey" PRIMARY KEY (id))');
    await database.execute(
        'CREATE TABLE "Business" (id character varying(255) NOT NULL, name character varying(255),description character varying(255),adress character varying(255),phone character varying(255),email character varying(255),photo character varying(255),photoUrl character varying(255),"valorationsQuantity" bigint,"valorationSum" double precision, valoration double precision,"deliveryPrice" double precision,CONSTRAINT "Business_pkey" PRIMARY KEY (id))');
    await database.execute(
        'CREATE TABLE "Favorite" (id character varying(255) NOT NULL,name character varying(255) NOT NULL,description character varying(255),price double precision NOT NULL,photo character varying(255) NOT NULL,photoUrl character varying(255) NOT NULL,"isAvailable" boolean DEFAULT false,availability integer DEFAULT 0,CONSTRAINT "Favorite_pkey" PRIMARY KEY (id))');
    await database.execute(
        'CREATE TABLE "Food" (id character varying(255) NOT NULL,name character varying(255) NOT NULL,description character varying(255),price double precision NOT NULL,photo character varying(255) NOT NULL,photoUrl character varying(255) NOT NULL,"isAvailable" integer DEFAULT false,"isFavorite" integer DEFAULT false,availability integer DEFAULT 0,CONSTRAINT "Food_pkey" PRIMARY KEY (id))');
    await database.execute(
        'CREATE TABLE "Addons" (id character varying(255) NOT NULL,name character varying(255) NOT NULL,price double precision NOT NULL,CONSTRAINT "Addons_pkey" PRIMARY KEY (id))');
    await database.execute(
        'CREATE TABLE "Provinces"(id character varying(255) NOT NULL,name character varying(255) NOT NULL,CONSTRAINT "Provinces_pkey" PRIMARY KEY (id),CONSTRAINT "Provinces_name_key" UNIQUE (name))');
    await database.execute(
        'CREATE TABLE "Municipalities"(id character varying(255) NOT NULL,name character varying(255),"provinceFk" character varying(255) NOT NULL,CONSTRAINT "Municipalities_pkey" PRIMARY KEY (id))');
    await database.execute(
        'CREATE TABLE "Sessions" (id character varying(255) NOT NULL,platform character varying(255),"systemVersion" character varying(255),"deviceId" character varying(255),model character varying(255), CONSTRAINT "Devices_pkey" PRIMARY KEY (id))');
    await database.execute(
        'CREATE TABLE "Users"(id character varying(255) NOT NULL,email character varying(255),"fullName" character varying(255),adress character varying(255),photo character varying(255),photoName character varying(255),CONSTRAINT "Users_pkey" PRIMARY KEY (id))');
  }
}
