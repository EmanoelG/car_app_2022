import 'dart:async';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.getInstance();
  DatabaseHelper.getInstance();

  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      print('_db>> $_db');
      return _db;
    }
    _db = await _initDb();
    print('_db>>>> $_db');
    return _db;
  }

  Future _initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'carros.db');
    print("db $path");

    var db = await openDatabase(path,
        version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    try {
      //C:\Flutter Project\list_car\assets\sql\create_sql
      String s = await rootBundle.loadString("assets/sql/create_sql");
      List<String> listS = s.split(';');
      listS.forEach(
        (script) async {
          print('ASSEST SCRIPT $script');
          if (script.isNotEmpty) {
            await db.execute(script);
          }
        },
      );
    } on Exception catch (e) {
      print('Erro ao criar database: $e');
    }
  }

  Future<FutureOr<void>> _onUpgrade(
      Database db, int oldVersion, int newVersion) async {
    print("_onUpgrade: oldVersion: $oldVersion > newVersion: $newVersion");

    if (oldVersion == 1 && newVersion == 2) {
      await db.execute("alter table carro add column NOVA TEXT");
    }
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
