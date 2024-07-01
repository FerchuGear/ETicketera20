import 'package:flutter/material.dart';
import 'package:eticketera20/themes/app_theme.dart';

class ThemeNotifier extends ChangeNotifier {
  bool _isDarkTheme = false;
  ThemeData _currentTheme = ThemeData.light();

  ThemeNotifier() {
    _currentTheme = _isDarkTheme ? AppTheme.darkTheme : ThemeData.light();
  }

  bool get isDarkTheme => _isDarkTheme;
  ThemeData get currentTheme => _currentTheme;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    _currentTheme = _isDarkTheme ? AppTheme.darkTheme : ThemeData.light();
    notifyListeners();
  }
}

