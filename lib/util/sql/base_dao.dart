import 'dart:async';
import 'package:sqflite/sqflite.dart';

import '../../pages/carro/carro.dart';
import 'db_helper.dart';
import 'entity.dart';

// Data Access Object
abstract class BaseDAO<T extends Entity> {
  String get tableName;
  T fromJson(Map<String, dynamic> map);
  Future<Database> get db => DatabaseHelper.getInstance().dbs;

  Future<int> save(T entity) async {
    var dbClient = await db;
    var id = await dbClient.insert("$tableName", entity.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print('id: $id');
    return id;
  }

  Future<List<T>> findAll() async {
    return await query('select * from $tableName ');
  }

  Future<List<T>> query(String sql, [List<Object>? arguments]) async {
    final dbClient = await db;

    final list = await dbClient.rawQuery(sql, arguments);

    return list.map<T>((json) => fromJson(json)).toList();
  }

  Future findById(int id) async {
    var dbClient = await db;
    final list =
        await dbClient.rawQuery('select * from $tableName where id = ?', [id]);

    if (list.length > 0) {
      return fromJson(list.first);
    }

    return null;
  }

  Future<bool> exists(int id) async {
    T c = await findById(id);
    var exists = c != null;
    return exists;
  }

  Future<int?> count() async {
    final dbClient = await db;
    final list = await dbClient.rawQuery('select count(*) from $tableName');
    return Sqflite.firstIntValue(list);
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient
        .rawDelete('delete from $tableName where id = ?', [id]);
  }

  Future<int> deleteAll() async {
    var dbClient = await db;
    return await dbClient.rawDelete('delete from $tableName');
  }
}
