import 'package:flutter/cupertino.dart';
import 'package:noteapp/config/config.dart';

class NoteViewNotifier extends ChangeNotifier {
  late int _crossAxisCount;

  int get crossAxisCount => _crossAxisCount;

  void changeAxisCount() {
    _crossAxisCount == 1 ? _crossAxisCount = 2 : _crossAxisCount = 1;
    saveAxisCount(count: _crossAxisCount);
    notifyListeners();
  }

  Future<void> saveAxisCount({required int count}) async {
    await Config.sharedPreferences!.setInt('cac', count);
    getAxisCount();
    notifyListeners();
  }

  void getAxisCount() {
    _crossAxisCount = Config.sharedPreferences!.getInt('cac') ?? 2;
    notifyListeners();
  }
}
