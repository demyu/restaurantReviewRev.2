import 'dart:async';
import 'package:path/path.dart';
import 'package:restaurantreviewrev2/Restaurant.dart';
import 'package:sqflite/sqflite.dart';

import 'Reviewer.dart';
import 'Reviews.dart';
import 'Restaurant.dart';

class DBHelper {
  static DBHelper _dbHelper;
  static Database _db;

  DBHelper._createInstance();
  factory DBHelper() {
    if (_dbHelper == null) {
      _dbHelper = DBHelper._createInstance();
    }
    return _dbHelper;
  }

  Future<Database> initializeDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'proto1.db'),
      onCreate: (db, version) {
        String table1 = """CREATE TABLE reviewer(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            reviewername VARCHAR NOT NULL
          )""";
        String table2 = """CREATE TABLE restaurant(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            restaurantname VARCHAR NOT NULL
          )""";
        String table3 = """CREATE TABLE reviews(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            reviewername VARCHAR NOT NULL,
            restaurantname VARCHAR NOT NULL,
            review VARCHAR NOT NULL,
            stars integer NOT NULL
          )""";
        db.execute(table1);
        db.execute(table2);
        db.execute(table3);
      },
      version: 1,
    );
  }

  Future<Database> getDatabase() async {
    if (_db == null) {
      _db = await initializeDatabase();
    }
    return _db;
  }

  Future<List<Reviewer>> getUserList() async {
    var db = await this.getDatabase();
    var list = await db.query('reviewer');
    List<Reviewer> userList = [];
    for (var data in list) {
      userList.add(Reviewer.fromDB(data));
    }
    return userList;
  }

  Future<List<Restaurant>> getRestaurantList() async {
    var db = await this.getDatabase();
    var list = await db.query('restaurant');
    List<Restaurant> userList = [];
    for (var data in list) {
      userList.add(Restaurant.fromDB(data));
    }
    return userList;
  }

  Future<List<Reviews>> getReviewsList() async {
    var db = await this.getDatabase();
    var list = await db.query('reviews');
    List<Reviews> userList = [];
    for (var data in list) {
      userList.add(Reviews.fromDB(data));
    }
    return userList;
  }

  Future<int> addUser(Reviewer user) async {
    var db = await this.getDatabase();
    print(user.getUsername());
    return await db.insert('reviewer', user.toMap());
  }

  Future<int> addRestaurant(Restaurant restaurant) async {
    var db = await this.getDatabase();
    return await db.insert('restaurant', restaurant.toMap());
  }

  Future<int> addReview(Reviews review) async {
    var db = await this.getDatabase();
    return await db.insert('reviews', review.toMap());
  }

  Future<List<Reviewer>> check() async {
    var db = await this.getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('reviewer');
    print(maps.length);
    return List.generate(maps.length, (index) {
      return Reviewer(maps[index]['name']);
    });
  }
}
