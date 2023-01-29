import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

final box = GetStorage();

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode =
      box.read('darkmode') == true ? ThemeMode.dark : ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    box.write('darkmode', isOn);
    notifyListeners();
  }
}
