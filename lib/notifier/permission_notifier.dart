import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

// if (!await Permission.microphone.isGranted ||
// !await Permission.audio.isGranted ||
// !await Permission.storage.isGranted) {
// PermissionStatus statusMic = await Permission.microphone.request();
// PermissionStatus statusAudio = await Permission.audio.request();
// PermissionStatus statusStorage = await Permission.storage.request();
// PermissionStatus statusManageExternal =
// await Permission.manageExternalStorage.request();
// if (statusMic != PermissionStatus.granted ||
// statusAudio != PermissionStatus.granted ||
// statusStorage != PermissionStatus.granted ||
// statusManageExternal != PermissionStatus.granted) {
// return false;
// }
// }
class PermissionNotifier extends ChangeNotifier {
  Future<bool> checkMicPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus statusMic = await Permission.microphone.request();
      if (statusMic != PermissionStatus.granted) {
        return false;
      }
    }

    notifyListeners();

    return true;
  }

  Future<bool> checkStoragePermission() async {
    if (!await Permission.camera.isGranted) {
      PermissionStatus statusCamera = await Permission.camera.request();
      if (statusCamera != PermissionStatus.granted) {
        return false;
      }
    }
    notifyListeners();

    return true;
  }
}
