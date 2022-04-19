import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:fl_control_gastos/models/movimientos_model.dart';
export 'package:fl_control_gastos/models/movimientos_model.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  Future<dynamic> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'conga10DB.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE transacciones(
            id INTEGER PRIMARY KEY,
            categoria TEXT,
            descripcion TEXT,
            valor REAL
          )

        ''');

        await db.execute(
          '''
          CREATE TABLE cuentas(
            id INTEGER PRIMARY KEY,
            cuenta TEXT,
            usuario TEXT
          )
          '''
        );

        await db.execute('''
        
          CREATE TABLE categorias(
            id INTEGER PRIMARY KEY,
            categoria TEXT,
            tipo TEXT
          )
        ''');
    });
  }

  Future<int> nuevoDato(MovimientosModel nuevoDato) async {
    final id = nuevoDato.id;
    final categoria = nuevoDato.categoria;
    final cuenta = nuevoDato.cuenta;
    final descripcion = nuevoDato.descripcion;
    final valor = nuevoDato.valor;

    //verificar la db
    final db = await database;

    final res = await db!.rawInsert('''
      INSERT INTO transacciones(id, categoria, cuenta, descripcion, valor)
        VALUES( $id, '$categoria', '$cuenta', '$descripcion', '$valor' )
      ''');

    return res;
  }

  Future<int> nuevoDatoRaw(MovimientosModel nuevoDato) async {
    final db = await database;
    final res = await db!.insert('transacciones', nuevoDato.toJson());
    //id del ultimo registro
    return res;
  }

  Future<MovimientosModel> getDatosById(int id) async {
    final db = await database;
    final res = await db!.query('transacciones', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? MovimientosModel.fromJson(res.first) : MovimientosModel(categoria: '', cuenta: '', descripcion: '', valor: 0.0);
  }

  Future<List<MovimientosModel>> getTodos() async {
    final db = await database;
    final res = await db!.query('transacciones', orderBy: 'id DESC');

    return res.isNotEmpty ? res.map((s) => MovimientosModel.fromJson(s)).toList() : [];
  }

    Future<MovimientosModel> getDatosByCategoria(String categoria) async {
      final db = await database;
      final res = await db!.rawQuery('''
        SELECT * FROM transacciones WHERE categoria = '$categoria'
      ''');

      return res.isNotEmpty
        ? res.map((s) => MovimientosModel.fromJson(s)).toList().first
        : MovimientosModel(categoria: '', cuenta: '', descripcion: '', valor: 0.0);
    }

  Future<int> updateDato(MovimientosModel nuevoDato) async {
    final db = await database;
    final res = await db!.update('transacciones', nuevoDato.toJson(),
        where: 'id = ?', whereArgs: [nuevoDato.id]);

    return res;
  }

  Future<int> deleteDato(int id) async {
    final db = await database;
    final res = await db!.delete('transacciones', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllDeportes() async {
    final db = await database;
    final res = await db!.delete('transacciones');
    return res;
  }
  
}