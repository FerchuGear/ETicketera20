import 'package:flutter/material.dart';
import 'package:eticketera20/themes/app_theme.dart';

class ThemeNotifier extends ChangeNotifier {
  bool _isDarkTheme = false;
  ThemeData _currentTheme = AppTheme.dayTheme;

  ThemeNotifier() {
    _currentTheme = _isDarkTheme ? AppTheme.darkTheme : AppTheme.dayTheme;
  }

  bool get isDarkTheme => _isDarkTheme;
  ThemeData get currentTheme => _currentTheme;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    _currentTheme = _isDarkTheme ? AppTheme.darkTheme : AppTheme.dayTheme;
    notifyListeners();
  }
}

