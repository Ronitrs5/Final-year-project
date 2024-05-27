import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier{
  bool _isDark = false;
  bool get isDark => _isDark;

  final darkTheme = ThemeData(
    brightness: Brightness.dark,
  );

  final lightTheme = ThemeData(
    brightness: Brightness.light
  );

  changeTheme(){
    _isDark = !isDark;
    notifyListeners();
  }


  init(){
    notifyListeners();
  }
}