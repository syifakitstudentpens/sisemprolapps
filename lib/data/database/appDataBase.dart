import 'package:sisemprol/data/category/Category.dart';
import 'package:sisemprol/data/jadwal/Jadwal.dart';
import 'package:tinano/tinano.dart';
import 'dart:async';
part 'appDataBase.g.dart'; // this is important!

@TinanoDb(name: "jadwal_app.sqlite", schemaVersion: 2)
abstract class AppDatabase {
  static DatabaseBuilder<AppDatabase> createBuilder() => _$createAppDatabase();

  @Query("SELECT COUNT(*) FROM categories")
  Future<int> getAllCategoryCount();

  @Query("SELECT * FROM categories")
  Future<List<Category>> getAllCategory();

  @Query('Delete from categories')
  Future<int> deleteAllCategory();

  @Insert(
    "INSERT INTO categories (id,name,imageUrl,description) VALUES (:id,:name,:image,:description)",
  )
  Future<int> createCategory(
      int id, String name, String image, String description);

  ///jadwal
  @Query("SELECT COUNT(*) FROM jadwal")
  Future<int> getAllJadwalCount();

  @Query("SELECT * FROM jadwal")
  Future<List<Jadwal>> getAllJadwal();

  @Query("SELECT * FROM jadwal where type = :type")
  Future<List<Jadwal>> getAllJadwalByType(String type);

  @Query("SELECT * FROM jadwal where categoryId = :categoryId")
  Future<List<Jadwal>> getAllJadwalForCategory(int categoryId);

  @Query("SELECT * FROM jadwal where categoryId = :categoryId and type = :type")
  Future<List<Jadwal>> getAllJadwalForCategoryAndType(
      int categoryId, String type);

  @Query("SELECT * FROM fav_jadwal")
  Future<List<Jadwal>> getFavJadwal();

  @Query("SELECT * FROM fav_jadwal where id = :id")
  Future<Jadwal> getFavJadwalById(int id);

  @Query("SELECT * FROM jadwal where id = :id")
  Future<Jadwal> getJadwalById(int id);
  @Query('Delete from jadwal')
  Future<int> deleteAllJadwal();

  @Insert(
      "INSERT INTO jadwal (id,title,body,image,categoryId,type,published,publishedAt,categoryName) VALUES (:id,:title,:body,:image,:categoryId,:type,:published,:publishedAt,:categoryName)")
  Future<int> createJadwal(
      int id,
      String title,
      String body,
      String image,
      int categoryId,
      String type,
      int published,
      String publishedAt,
      String categoryName);

  @Query('Delete from fav_jadwal where id =:id')
  Future<int> deleteFavJadwal(int id);

  @Query('Delete from jadwal where id =:id')
  Future<int> deleteJadwal(int id);

  @Insert("INSERT INTO fav_jadwal (id,title,body,image,categoryId,type,published,publishedAt,categoryName) " +
      "VALUES (:id,:title,:body,:image,:categoryId,:type,:published,:publishedAt,:categoryName)")
  Future<int> createFavJadwal(
      int id,
      String title,
      String body,
      String image,
      int categoryId,
      String type,
      int published,
      String publishedAt,
      String categoryName);

  static Future<AppDatabase> openMyDatabase() async {
    return await (AppDatabase.createBuilder().doOnCreate((db, version) async {
      await db.execute("""
        CREATE TABLE `categories` ( `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `imageUrl` TEXT  NULL, `description` TEXT  NULL );
        """);
      await db.execute("""
        CREATE TABLE `jadwal` ( 
          `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
          `name` TEXT NULL,
          `title` TEXT NULL,
          `body` TEXT NULL,
          `image` TEXT NULL,
          `categoryId` INT NULL,
          `type` TEXT NULL,
          `published` INT NULL,
          `publishedAt` TEXT NULL,
          `categoryName` TEXT NULL
          );""");
      await db.execute("""
        CREATE TABLE `fav_jadwal` ( 
          `id` INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
          `name` TEXT NULL,
          `title` TEXT NULL,
          `body` TEXT NULL,
          `image` TEXT NULL,
          `categoryId` INT NULL,
          `type` TEXT NULL,
          `published` INT NULL,
          `publishedAt` TEXT NULL,
          `categoryName` TEXT NULL
          );""");
    }).build());
  }
}
