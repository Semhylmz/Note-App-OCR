import 'package:encrypt/encrypt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class KeysService {
  FlutterSecureStorage createSecureStorage() {
    FlutterSecureStorage secureStorage = const FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true));
    return secureStorage;
  }

  Future<void> saveDbKeys() async {
    String key = Key.fromSecureRandom(32).base64;
    String keyRes = key.substring(key.length - 32, key.length);

    String iv = IV.fromSecureRandom(16).base64;
    String ivRes = iv.substring(iv.length - 16, iv.length);

    final secureStorage = createSecureStorage();
    await secureStorage.write(key: 'encrypterKey', value: keyRes);
    await secureStorage.write(key: 'encrypterIv', value: ivRes);
  }

  Future<String> getDbKeys() async {
    final secureStorage = createSecureStorage();
    return await (secureStorage.read(key: 'encrypterKey')) ?? '';
  }

  Future<String> getDbIv() async {
    final secureStorage = createSecureStorage();
    return await (secureStorage.read(key: 'encrypterIv')) ?? '';
  }
}
