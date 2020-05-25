
import 'dart:io';
import 'package:countdown/model/event.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {

  static final _database = 'events.db';
  static final _version = 3;

  static final _table = 'events';
  static final colId = 'id';
  static final colName = 'name';
  static final colDate = 'date';
  static final colImage = 'image';

  DatabaseService._privateConstructor();
  static final DatabaseService instance = DatabaseService._privateConstructor();

  static Database _db;
  Future<Database> get database async {
    if(_db != null) return _db;
    _db = await _initDatabase();
    return _db;
  }

  _initDatabase() async {
    Directory _directory = await getApplicationDocumentsDirectory();
    String _path = join(_directory.path, _database);
    return await openDatabase(
      _path,
      version: _version,
      onCreate: _onCreate,);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_table (
        $colId INTEGER PRIMARY KEY,
        $colName TEXT NOT NULL,
        $colDate TEXT NOT NULL,
        $colImage TEXT NOT NULL
      )
    ''');
  }

  Future<List<Event>> getAllEvents() async {
    Database db = await instance.database;
    var _query = await db.query(_table);
    return _query.map((e) => Event.fromMap(e)).toList();
  }

  Future<int> insertEvent(Event _event) async {
    Database db = await instance.database;
    return await db.insert(_table, _event.toMap());
  }

  Future<int> deleteEvent(int id) async {
    Database db = await instance.database;
    return await db.delete(_table, where: '$colId = ?', whereArgs: [id]);
  }

  Future<int> updateEvent(Event _event) async {
    Database db = await instance.database;
    return await db.update(_table, _event.toMap(), where: '$colId = ?', whereArgs: [_event.id]);
  }
}