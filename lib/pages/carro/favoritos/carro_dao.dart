import 'dart:async';
import 'package:sqflite/sqflite.dart';
import '../carro.dart';
import '../../../util/sql/base_dao.dart';
import '../../../util/sql/db_helper.dart';

// Data Access Object
class CarroDAO extends BaseDAO<Carros> {
  @override
  // TODO: implement tableName
  String get tableName => "carro";

  @override
  Carros fromJson(Map<String, dynamic> map) {
    return Carros.fromJson(map);
  }

  Future<List<Carros>> findAllByTipo(String tipo) async {
    final dbClient = await db;

    final list =
        await dbClient.rawQuery('select * from carro where tipo =? ', [tipo]);

    return list.map<Carros>((json) => fromJson(json)).toList();
  }
}
