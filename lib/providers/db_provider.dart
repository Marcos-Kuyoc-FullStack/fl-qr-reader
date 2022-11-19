// Crear un singleton de la Base de datos
import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:qr_reader/models/scan_mode.dart';
export 'package:qr_reader/models/scan_mode.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async {
    // Path de donde se almacenara la DB
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');
    // ignore: avoid_print
    print(path);

    // Crear la BD
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          )
        ''');
      },
    );
  }

  Future<int> nuevoScanRaw(ScanModel nuevoScan) async {
    // verificar DB
    final db = await database;
    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;

    final result = await db.rawInsert('''
            INSERT INTO Scans(id, tipo, valor)
            VALUES($id, '$tipo', '$valor')
          ''');

    return result;
  }

  Future<int> nuevoScan(ScanModel nuevoScan) async {
    final db = await database;
    final result = await db.insert('Scans', nuevoScan.toMap());

    // Regresa el Id del ultimo elemento registrado
    return result;
  }

  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final result = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    // Regresa el Id del ultimo elemento registrado
    return result.isNotEmpty ? ScanModel.fromMap(result.first) : null;
  }

  Future<List<ScanModel>> getAllScan() async {
    final db = await database;
    final result = await db.query('Scans');

    // Regresa el Id del ultimo elemento registrado
    final List<ScanModel> listResult =
        result.map((s) => ScanModel.fromMap(s)).toList();

    return result.isNotEmpty ? listResult : [];
  }

  Future<List<ScanModel>> getAllScanByType(String tipo) async {
    final db = await database;
    final result = await db.rawQuery('''
      SELECT * FROM Scans WHERE tipo = '$tipo'
    ''');

    // Regresa el Id del ultimo elemento registrado
    final List<ScanModel> listResult =
        result.map((s) => ScanModel.fromMap(s)).toList();

    return result.isNotEmpty ? listResult : [];
  }

  Future<int> updateScan(ScanModel nuevoScan) async {
    final db = await database;
    final result = db.update('Scans', nuevoScan.toMap(),
        where: 'id = ? ', whereArgs: [nuevoScan.id]);

    return result;
  }

  Future<int> deteleScan(int id) async {
    final db = await database;
    final result = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);

    return result;
  }

  Future<int> deteleAllScan() async {
    final db = await database;
    final result = await db.rawDelete('''
      DELETE FROM Scans
    ''');

    return result;
  }
}
