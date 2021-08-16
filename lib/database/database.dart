import 'package:new_design_news_app/model/favourite_data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final database = db();
const favouriteNews = 'favourite';
String colId = 'id';
String colDate = 'date';
String colTitle = 'title';
String colDescription = 'description';
String colImage = 'Image';

Future<Database> db() async {
  return openDatabase(
    join(await getDatabasesPath(), 'favourite_db.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE IF NOT EXISTS $favouriteNews(id INTEGER PRIMARY KEY,date TEXT, title TEXT, description TEXT, link TEXT, isFavourite BIT, image TEXT)',
      );
    },
    version: 1,
  );
}

Future<List<Map<String, dynamic>>> getFavouriteMapList() async {
  final Database db = await database;
  var result = await db.query(favouriteNews, orderBy: '$colId ASC');
  return result;
}

Future<List<FavouriteData>> getFavouriteList() async {
  var favouriteMapList =
      await getFavouriteMapList(); // Get 'Map List' from database
  int count =
      favouriteMapList.length; // Count the number of map entries in db table
  List<FavouriteData> favouriteList = [];
  // For loop to create a 'Movie List' from a 'Map List'
  for (int i = 0; i < count; i++) {
    favouriteList.add(FavouriteData.fromMap(favouriteMapList[i]));
  }
  return favouriteList;
}

Future<int> insertNews(FavouriteData favouriteData) async {
  // Get a reference to the database.
  final Database db = await database;
  var result = await db.insert(
    favouriteNews,
    favouriteData.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );

  return result;
}

Future<void> updateNews(FavouriteData favouriteData) async {
  // Get a reference to the database.
  final db = await database;

  // Update the given Product.
  await db.update(
    favouriteNews,
    favouriteData.toMap(),
    // Ensure that the Product has a matching id.
    where: "id = ?",
    // Pass the Products's id as a whereArg to prevent SQL injection.
    whereArgs: [favouriteData.id],
  );
}

Future<int> deleteFavourite(int id) async {
  // Get a reference to the database.
  final db = await database;

  // Remove the Product from the database.
  int result = await db.delete(
    favouriteNews,
    // Use a `where` clause to delete a specific product.
    where: "id = ?",
    // Pass the Products's id as a whereArg to prevent SQL injection.
    whereArgs: [id],
  );

  return result;
}

Future<int?> getCount() async {
  final db = await database;
  List<Map<String, dynamic>> x =
      await db.rawQuery('SELECT * FROM $favouriteNews');
  int? result = Sqflite.firstIntValue(x);
  return result;
}

// this function will check if a movies exists in the database.
Future<bool> contain(int id) async {
  final db = await database;
  List<Map<String, dynamic>> x =
      await db.rawQuery('SELECT * FROM $favouriteNews WHERE $colId = $id');
  int? result = Sqflite.firstIntValue(x);
  if (result == 0) return false;
  return true;
}

Future<void> clearTable() async {
  final db = await database;
  await db.rawDelete("DELETE FROM $favouriteNews");
}
