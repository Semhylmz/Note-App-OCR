import 'package:flutter/cupertino.dart';
import 'package:noteapp/service/encrypter_note_service.dart';
import 'package:noteapp/utils/db_helpers.dart';
import '../model/note_db_model.dart';

class NoteNotifier extends ChangeNotifier {
  List<NoteDbModel> _list = [];

  late bool _isLoading;

  bool _isProcessing = false;

  bool get isLoading => _isLoading;

  bool get isProcessing => _isProcessing;

  set setIsLoading(bool value) {
    _isLoading = value;
  }

  set setIsProcessing(bool value) {
    _isProcessing = value;
    notifyListeners();
  }

  List<NoteDbModel> get list => _list.isEmpty ? [] : _list;

  Future<List<NoteDbModel>> getAllData() async {
    setIsLoading = true;
    List<NoteDbModel> temp = await NotesDatabaseHelper.instance.getData();

    _list = await EncryptNoteService().decryptNote(temp);

    setIsLoading = false;
    notifyListeners();
    return _list;
  }

  Future<void> addUpdate(NoteDbModel noteDbModel, bool isFirst, int? id) async {
    setIsProcessing = true;

    NoteDbModel noteDbModel1 =
        await EncryptNoteService().encryptNote(noteDbModel: noteDbModel);

    isFirst
        ? await NotesDatabaseHelper.instance.add(noteDbModel1)
        : await NotesDatabaseHelper.instance.update(noteDbModel1, id!);

    await getAllData();
    setIsProcessing = false;
    notifyListeners();
  }

  Future<void> remove(int id) async {
    await NotesDatabaseHelper.instance.remove(id);
    getAllData();
    notifyListeners();
  }
}
