import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:noteapp/constants/text_constants.dart';
import 'package:noteapp/notifier/permission_notifier.dart';
import 'package:noteapp/service/recorder_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record_mp3/record_mp3.dart';
import '../config/config.dart';

class RecorderNotifier extends ChangeNotifier {
  late TextEditingController _titleEditingController;
  late List<FileSystemEntity> _recordList;
  late List<FileSystemEntity> _tempRecordsList;
  final String _recordName = 'Sesli not';
  String _statusText = '';
  String _directoryPath = '';
  String _tempFileName = '';
  String _tempFilePath = '';

  bool _isRecording = false;
  bool _isPause = false;
  bool _isRecordCompleted = false;
  bool _isSave = false;
  bool _isLoading = false;
  late int _recordNameCount;

  TextEditingController get titleEditingController => _titleEditingController;

  List<FileSystemEntity> get recordList => _recordList;

  List<FileSystemEntity> get tempRecordsList => _tempRecordsList;

  String get statusText => _statusText;

  String get directoryPath => _directoryPath;

  String get tempFileName => _tempFileName;

  String get tempFilePath => _tempFilePath;

  bool get isRecording => _isRecording;

  bool get isPause => _isPause;

  bool get isRecordCompleted => _isRecordCompleted;

  bool get isSave => _isSave;

  bool get isLoading => _isLoading;

  set setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set setTempRecordList(bool value) {
    value ? _tempRecordsList.clear() : null;
    notifyListeners();
  }

  set setRecordName(String value) {
    _tempFileName = value;
    notifyListeners();
  }

  set setStatusText(String value) {
    _statusText = value;
    notifyListeners();
  }

  set setTempFileName(String value) {
    _tempFileName = value;
    notifyListeners();
  }

  set setTempFilePath(String value) {
    _tempFilePath = value;
    notifyListeners();
  }

  set setIsRecordCompleted(bool value) {
    _isRecordCompleted = value;
    notifyListeners();
  }

  set setIsSave(bool value) {
    _isSave = value;
    notifyListeners();
  }

  set setIsRecording(bool value) {
    _isRecording = value;
    notifyListeners();
  }

  set setIsPause(bool value) {
    _isPause = value;
    notifyListeners();
  }

  void initTitleController() {
    _titleEditingController = TextEditingController();
    //notifyListeners();
  }

  void disposeTitleController() {
    titleEditingController.clear();
    _titleEditingController.clear();
  }

  Future<void> directoryExisting({required bool isTemp}) async {
    var directory = Directory(isTemp ? tempFilePath : _directoryPath);
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }
  }

  Future<void> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();

    setTempFilePath = "${storageDirectory.path}/cache/";
    _directoryPath = "${storageDirectory.path}/voice note/";

    notifyListeners();
  }

  Future<void> startRecord() async {
    bool hasPermission = await PermissionNotifier().checkMicPermission();

    if (hasPermission) {
      await getFilePath();
      await directoryExisting(isTemp: true);
      setIsRecording = true;
      setIsRecordCompleted = false;

      setTempFileName = await RecorderService()
          .startRecord('$tempFilePath$_recordName $_recordNameCount.mp3');
    } else {
      Fluttertoast.showToast(msg: micPermission);
    }
    notifyListeners();
  }

  void configRecorderCounter() =>
      Config.sharedPreferences!.setInt('recorderCounter', 0);

  void getRecordNameCount() {
    _recordNameCount = Config.sharedPreferences!.getInt('recorderCounter')!;
  }

  Future<void> setRecordNameCount() async {
    Config.sharedPreferences!.setInt('recorderCounter', _recordNameCount + 1);
    getRecordNameCount();
    notifyListeners();
  }

  Future<void> stopRecord() async {
    bool stopResult = await RecorderService().stopRecord();
    if (stopResult) {
      setStatusText = "Kayıt tamamlandı";
      setIsRecording = false;
      setIsRecordCompleted = true;
    }
    await getTempRecords();
    notifyListeners();
  }

  Future<void> saveRecord() async {
    setIsSave = true;
    await directoryExisting(isTemp: false);

    await File(tempFilePath).rename('$directoryPath$tempFileName.mp3');

    await setRecordNameCount();

    await getRecords();

    defaultValues();

    notifyListeners();
  }

  void defaultValues() {
    setIsSave = false;
    setIsRecordCompleted = false;
    File(tempFilePath).delete();
    setStatusText = '';
    setTempFilePath = '';
    setRecordName = '';
    setTempRecordList = true;
  }

  Future<void> getRecords() async {
    setIsLoading = true;
    await getFilePath();
    bool isExists = await Directory(directoryPath).exists();
    if (isExists) {
      _recordList = await RecorderService().getRecords(directoryPath);
      _recordList.isEmpty ? _recordList = [] : _recordList;
    } else {
      _recordList = [];
    }
    setIsLoading = false;

    notifyListeners();
  }

  Future<void> getTempRecords() async {
    bool isExists = await Directory(_tempFilePath).exists();

    if (isExists) {
      _tempRecordsList = await RecorderService().getRecords(_tempFilePath);

      if (_tempRecordsList.isEmpty) {
        _tempFileName = '';
        _tempFilePath = '';
      } else {
        int startValue = _tempRecordsList[0]
            .path
            .lastIndexOf('/', _tempRecordsList[0].path.length);
        int endValue = _tempRecordsList[0].path.length;

        _tempFilePath = _tempRecordsList[0].path;
        _tempFileName =
            _tempRecordsList[0].path.substring(startValue + 1, endValue - 4);
      }
    } else {
      _tempRecordsList = [];
    }

    notifyListeners();
  }

  pauseRecord() async {
    if (RecordMp3.instance.status == RecordStatus.PAUSE) {
      setIsRecording = false;
      setIsRecordCompleted = false;
      setIsPause = true;

      bool s = RecordMp3.instance.resume();
      if (s) {
        setStatusText = "Kayıtta...";
      }
    } else {
      bool s = RecordMp3.instance.pause();
      if (s) {
        setStatusText = "Kayıt durduruldu...";
      }
    }
    notifyListeners();
  }

  Future<void> resumeRecord() async {
    bool s = RecordMp3.instance.resume();
    setIsRecording = true;
    setIsRecordCompleted = false;
    setIsPause = false;

    if (s) {
      setStatusText = "Kayıtta...";
    }
    notifyListeners();
  }

  Future<void> deleteRecord(
      {required bool isTemp, required String path}) async {
    await File(path).delete();
    isTemp ? defaultValues() : await getRecords();
  }

  void searchRecord(List<FileSystemEntity> files) {
    for (FileSystemEntity entity in files) {
      String path = entity.path;
      if (path.endsWith('.mp3')) _recordList.add(entity);
    }
    notifyListeners();
  }
}
