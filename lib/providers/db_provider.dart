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
    final result = db.insert('Scans', nuevoScan.toMap());
    return result;
  }
}
