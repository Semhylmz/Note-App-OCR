import 'dart:io';
import 'package:record_mp3/record_mp3.dart';

class RecorderService {
  Future<void> createDirectory(String path) async {
    var directory = Directory(path);
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }
  }

  Future<List<FileSystemEntity>> getRecords(String path) async {

    return Directory(path).listSync(recursive: true, followLinks: false);
  }

  Future<String> startRecord(String recordTempFilePath) async {
    String setStatusText = '';
    RecordMp3.instance.start(recordTempFilePath, (type) {
      setStatusText = "Kayıtta hata oldu--->$type";
    });
    return setStatusText;
  }

  Future<bool> stopRecord() async {
    return RecordMp3.instance.stop();
  }

  Future<bool> pauseRecord() async {
    return RecordMp3.instance.pause();
  }

  Future<bool> resumeRecord() async {
    return RecordMp3.instance.pause();
  }

  Future<RecordStatus> recorderStatus() async {
    return RecordMp3.instance.status;
  }
}
