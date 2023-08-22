import 'package:flutter/cupertino.dart';
import '../service/encrypter_keys_service.dart';

class EncrypterKeyNotifier extends ChangeNotifier {
  late final KeysService keysService;

  Future<void> saveDbKeys() async {
    keysService = KeysService();
    await keysService.saveDbKeys();
  }
}
