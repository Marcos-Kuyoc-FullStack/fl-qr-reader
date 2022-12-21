import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class MapasScreen extends StatelessWidget {
  const MapasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScanTiles(tipo: 'geo');
  }
}
