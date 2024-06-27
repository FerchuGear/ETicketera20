import 'package:flutter/material.dart';
import 'package:eticketera20/themes/app_theme.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme = AppTheme.darkTheme;

  ThemeData get currentTheme => _currentTheme;

  void toggleTheme() {
    if (_currentTheme == AppTheme.darkTheme) {
      _currentTheme = ThemeData.light();
    } else {
      _currentTheme = AppTheme.darkTheme;
    }
    notifyListeners();
  }
}
