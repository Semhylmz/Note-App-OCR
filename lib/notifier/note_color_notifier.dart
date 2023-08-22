import 'package:flutter/material.dart';
import '../constants/color_list.dart';

class NoteColorNotifier extends ChangeNotifier {
  final int _colorSize = colorList.length;

  String _defaultColor = Colors.transparent.value.toString();

  String get selectedColor => _defaultColor;

  int get colorSize => _colorSize;

  void initColor({required String colorVal}) {
    _defaultColor = colorVal;
    notifyListeners();
  }

  void chooseColor(int idx) async {
    _defaultColor = colorList[idx].value.toString();
    notifyListeners();
  }

  Future<void> defaultColor() async {
    _defaultColor = Colors.transparent.value.toString();
    notifyListeners();
  }
}
