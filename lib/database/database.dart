import 'package:new_design_news_app/model/favourite_data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final database = db();
const favouriteNews = 'favourite';

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

Future<void> insertNews(FavouriteData favouriteData) async {
  // Get a reference to the database.
  final Database db = await database;

  // Insert the Product into the correct table. Also specify the
  // `conflictAlgorithm`. In this case, if the same product is inserted
  // multiple times, it replaces the previous data.
  await db.insert(
    favouriteNews,
    favouriteData.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<FavouriteData>> allFavouriteNews() async {
  // Get a reference to the database.
  final Database db = await database;

  // Query the table for all The Products.
  final List<Map<String, dynamic>> maps = await db.query(favouriteNews);

  // Convert the List<Map<String, dynamic> into a List<Product>.
  return List.generate(
    maps.length,
    (i) {
      return FavouriteData(
        id: maps[i]['id'],
        date: maps[i]['date'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        link: maps[i]['link'],
        isFavourite: maps[i]['isFavourite'] == 1,
        image: maps[i]['image'],
      );
    },
  );
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

Future<void> deleteFavourite(int id) async {
  // Get a reference to the database.
  final db = await database;

  // Remove the Product from the database.
  await db.delete(
    favouriteNews,
    // Use a `where` clause to delete a specific product.
    where: "id = ?",
    // Pass the Products's id as a whereArg to prevent SQL injection.
    whereArgs: [id],
  );
}

Future<List<FavouriteData>> getFavourite(int id) async {
  final db = await database;
  var result = await db.rawQuery(
      'SELECT * FROM $favouriteNews WHERE ${FavouriteData.db_id} = "1"');

  if (result.length == 0) return [];
  List<FavouriteData> list = [];
  for (Map<String, dynamic> map in result) {
    list.add(new FavouriteData.fromMap(map));
  }

  return list;
}

Future<void> clearTable() async {
  final db = await database;
  await db.rawDelete("DELETE FROM $favouriteNews");
}
