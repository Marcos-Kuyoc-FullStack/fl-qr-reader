// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan-list-provider.dart';
import 'package:qr_reader/utils/utils.dart';

import '../models/scan_mode.dart';
//import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanButtom extends StatelessWidget {
  const ScanButtom({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: const Icon(Icons.filter_center_focus),
      onPressed: () async {
        try {
          const barcodeScanRes = 'geo:21.146516,-88.1528344';
          // String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          //     '#3D8BEF', 'Cancelar', false, ScanMode.QR);
          if (barcodeScanRes == '-1') {
            return;
          }

          final scanListProvider =
              Provider.of<ScanListProvider>(context, listen: false);

          final nuevoScan = await scanListProvider.nuevoScan(barcodeScanRes);
          // ignore: use_build_context_synchronously
          launchURL(context, nuevoScan);
        } on PlatformException catch (e) {
          throw Exception(e.message);
        }
      },
    );
  }
}
