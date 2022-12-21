import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';

  Future<ScanModel> nuevoScan(String valor) async {
    final nuevoScan = ScanModel(valor: valor);
    final id = await DBProvider.db.nuevoScan(nuevoScan);

    // Asignar el ID de la DB al modelo
    nuevoScan.id = id;

    // Mostrar en la interfaz segun el tipo
    if (tipoSeleccionado == nuevoScan.tipo) {
      scans.add(nuevoScan);
      notifyListeners();
    }

    return nuevoScan;
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

  borrarScanPorId(id) async {
    await DBProvider.db.deteleScan(id);
    cargarScanPortipo(tipoSeleccionado);
  }
}
