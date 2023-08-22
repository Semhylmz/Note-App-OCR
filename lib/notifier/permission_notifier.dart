import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionNotifier extends ChangeNotifier {
  Future<bool> checkMicPermission() async {
    if (!await Permission.microphone.isGranted ||
        !await Permission.storage.isGranted) {
      PermissionStatus statusMic = await Permission.microphone.request();
      PermissionStatus statusStorage = await Permission.storage.request();
      if (statusMic != PermissionStatus.granted ||
          statusStorage != PermissionStatus.granted) {
        return false;
      }
    }
    notifyListeners();

    return true;
  }

  Future<bool> checkStoragePermission() async {
    if (!await Permission.camera.isGranted ||
        !await Permission.storage.isGranted) {
      PermissionStatus statusCamera = await Permission.camera.request();
      PermissionStatus statusStorage = await Permission.storage.request();
      if (statusCamera != PermissionStatus.granted ||
          statusStorage != PermissionStatus.granted) {
        return false;
      }
    }
    notifyListeners();

    return true;
  }
}
