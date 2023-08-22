import 'package:flutter/material.dart';
import 'package:noteapp/theme/theme_data.dart';
import '../config/config.dart';

class ThemeNotifier extends ChangeNotifier {
  bool _isLight = true;

  bool get isLight => _isLight;

  ThemeData get theme => _isLight ? lightTheme : darkTheme;

  void changeTheme() async {
    _isLight = !_isLight;
    saveTheme();
    notifyListeners();
  }

  void saveTheme() async {
    Config.sharedPreferences!.setBool('isLight', _isLight);
  }

  void loadTheme() async {
    _isLight = Config.sharedPreferences!.getBool('isLight') ?? true;
  }
}
