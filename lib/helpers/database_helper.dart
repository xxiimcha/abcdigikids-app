import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'profiles.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE profiles(id INTEGER PRIMARY KEY, name TEXT, pin TEXT, avatar TEXT)",
        );
        await _insertDummyData(db);
      },
    );
  }

  Future<void> _insertDummyData(Database db) async {
    await db.insert('profiles', {
      'name': 'Elyn',
      'pin': '1234',
      'avatar': 'assets/default_avatar.jpg',
    });
    await db.insert('profiles', {
      'name': 'Me',
      'pin': '5678',
      'avatar': 'assets/default_avatar.jpg',
    });
    await db.insert('profiles', {
      'name': 'Elyan 2',
      'pin': '9101',
      'avatar': 'assets/default_avatar.jpg',
    });
    await db.insert('profiles', {
      'name': 'Meh',
      'pin': '1121',
      'avatar': 'assets/default_avatar.jpg',
    });
  }

  Future<List<Map<String, dynamic>>> getProfiles() async {
    Database db = await database;
    return await db.query('profiles');
  }

  Future<int> insertProfile(Map<String, dynamic> profile) async {
    Database db = await database;
    return await db.insert('profiles', profile);
  }

  Future<int> updateProfile(Map<String, dynamic> profile) async {
    Database db = await database;
    int id = profile['id'];
    return await db.update(
      'profiles',
      profile,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteProfile(int id) async {
    Database db = await database;
    return await db.delete(
      'profiles',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
