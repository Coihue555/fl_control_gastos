import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:fl_control_gastos/models/models.dart';
export 'package:fl_control_gastos/models/models.dart';

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
    final path = join(documentsDirectory.path, 'conga12DB.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE transacciones(
            id INTEGER PRIMARY KEY,
            categoria TEXT,
            cuenta TEXT,
            descripcion TEXT,
            valor REAL
          )

        ''');

        await db.execute(
          '''
          CREATE TABLE cuentas(
            id INTEGER PRIMARY KEY,
            nombreCuenta TEXT
          )
          '''
        );

        await db.execute('''
        
          CREATE TABLE categorias(
            id INTEGER PRIMARY KEY,
            nombreCategoria TEXT,
            tipoCategoria TEXT
          )
        ''');
    });
  }


//Transacciones

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


  // Cuentas
  Future<int> nuevaCuenta(CuentaModel nuevaCuenta) async {
    final db = await database;
    final res = await db!.insert('cuentas', nuevaCuenta.toJson());
    //id del ultimo registro
    return res;
  }

  Future<List<CuentaModel>> getCuentas() async {
    final db = await database;
    final res = await db!.query('cuentas', orderBy: 'id DESC');

    return res.isNotEmpty ? res.map((s) => CuentaModel.fromJson(s)).toList() : [];
  }

  Future<CuentaModel> getCuentaById(int id) async {
    final db = await database;
    final res = await db!.query('cuentas', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? CuentaModel.fromJson(res.first) : CuentaModel(nombreCuenta: '');
  }

  Future<int> deleteItem(String table, int id) async {
    final db = await database;
    final res = await db!.delete(table, where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> updateCuenta(CuentaModel nuevaCuenta) async {
    final db = await database;
    final res = await db!.update('cuentas', nuevaCuenta.toJson(),
        where: 'id = ?', whereArgs: [nuevaCuenta.id]);

    return res;
  }


    // Categorias
  Future<int> nuevaCategoria(CategoriaModel nuevaCategoria) async {
    final db = await database;
    final res = await db!.insert('categorias', nuevaCategoria.toJson());
    //id del ultimo registro
    return res;
  }

  Future<List<CategoriaModel>> getCategorias() async {
    final db = await database;
    final res = await db!.query('categorias', orderBy: 'id DESC');

    return res.isNotEmpty ? res.map((s) => CategoriaModel.fromJson(s)).toList() : [];
  }

  Future<CategoriaModel> getCategoriaById(int id) async {
    final db = await database;
    final res = await db!.query('categorias', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? CategoriaModel.fromJson(res.first) : CategoriaModel(nombreCategoria: '', tipoCategoria: '');
  }

  Future<int> updateCategoria(CategoriaModel nuevaCategoria) async {
    final db = await database;
    final res = await db!.update('categorias', nuevaCategoria.toJson(),
        where: 'id = ?', whereArgs: [nuevaCategoria.id]);

    return res;
  }



}