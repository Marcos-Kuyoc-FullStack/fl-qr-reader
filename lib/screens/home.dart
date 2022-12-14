import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/db_provider.dart';
import 'package:qr_reader/providers/scan-list-provider.dart';
import 'package:qr_reader/providers/ui_providers.dart';
import 'package:qr_reader/screens/direcciones.dart';
import 'package:qr_reader/screens/mapa.dart';

import '../widgets/widgets.dart';
import 'mapas.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              final scanListProvider =
                  Provider.of<ScanListProvider>(context, listen: false);
              scanListProvider.borrarTodos();
            },
            icon: const Icon(Icons.delete_forever),
          )
        ],
      ),
      body: const _HomeBody(),
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const ScanButtom(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    // obtener el selected del menu de opciones
    final uiProvider = Provider.of<UiProvider>(context);

    // Cambiar para mostrar la pantalla correspondiente
    final currenIndex = uiProvider.selectedMenuOption;

    // Usar el ScanListProvider (no se tiene que redibujar)
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (currenIndex) {
      case 0:
        scanListProvider.cargarScanPortipo('geo');
        return const MapasScreen();
      case 1:
        scanListProvider.cargarScanPortipo('http');
        return const DireccionesScreen();
      default:
        return const MapasScreen();
    }
  }
}
