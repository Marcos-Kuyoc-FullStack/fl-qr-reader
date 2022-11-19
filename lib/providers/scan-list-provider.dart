import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';

  nuevoScan(String valor) async {
    final nuevoScan = ScanModel(valor: valor);
    final id = await DBProvider.db.nuevoScan(nuevoScan);

    // Asignar el ID de la DB al modelo
    nuevoScan.id = id;

    // Mostrar en la interfaz segun el tipo
    if (tipoSeleccionado == nuevoScan.tipo) {
      scans.add(nuevoScan);
    }
    notifyListeners();
  }

  cargarScans() async {
    final listScans = await DBProvider.db.getAllScan();
    scans = [...listScans];
    notifyListeners();
  }

  cargarScanPortipo(String tipo) async {
    final listScans = await DBProvider.db.getAllScanByType(tipo);
    scans = [...listScans];
    tipoSeleccionado = tipo;
    notifyListeners();
  }

  borrarTodos() async {
    await DBProvider.db.deteleAllScan();
    scans = [];
    notifyListeners();
  }

  borrarPorId(int id) async {
    await DBProvider.db.deteleScan(id);
    scans = [];
    notifyListeners();
  }
}
