import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:noteapp/constants/text_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_auth_android/local_auth_android.dart';

class LocalAuthService extends ChangeNotifier {
  static final _auth = LocalAuthentication();
  late bool _isPassword;

  bool get isPassword => _isPassword;

  Future<void> setIsPassword({required bool value}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('isPassword', value);
    getIsPassword();
    notifyListeners();
  }

  void getIsPassword() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _isPassword = preferences.getBool('isPassword')!;
    notifyListeners();
  }

  static Future<List<BiometricType>> getBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      e.message;
      return <BiometricType>[];
    }
  }

  static Future<bool> isSupported() async {
    try {
      return await _auth.isDeviceSupported();
    } on PlatformException catch (e) {
      e.message;
      return false;
    }
  }

  static Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      e.message;
      return false;
    }
  }

  static Future<bool> authenticate() async {
    final isAvailable = await hasBiometrics();
    if (!isAvailable) return false;
    try {
      return await _auth.authenticate(
        localizedReason: ' ',
        authMessages: const <AuthMessages>[
          AndroidAuthMessages(
            signInTitle: biometricTitle,
            biometricHint: biometricHint,
            cancelButton: 'Vazgeç',
          ),
        ],
        options: const AuthenticationOptions(
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );
    } on PlatformException catch (e) {
      e.message;
      return false;
    }
  }
}
