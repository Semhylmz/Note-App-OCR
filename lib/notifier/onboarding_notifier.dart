import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingNotifier extends ChangeNotifier {
  /*late bool _isFirst;

  bool get isFirst => _isFirst;*/

  Future<void> saveOnboardData({required int value}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('isFirst', value);
    notifyListeners();
  }

/*Future<void> getOnboardData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _isFirst = preferences.getBool('isFirst')!;
    notifyListeners();
  }*/
}
