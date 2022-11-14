// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  int _selectedMenuOption = 1;

  int get selectedMenuOption {
    return _selectedMenuOption;
  }

  set selectedMenuOption(int i) {
    _selectedMenuOption = i;
    notifyListeners();
  }
}
