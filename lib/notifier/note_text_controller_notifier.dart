import 'package:flutter/cupertino.dart';

class NoteTextControllerNotifier extends ChangeNotifier {
  late TextEditingController _titleEditingController;
  late TextEditingController _categoryEditingController;
  late TextEditingController _textEditingController;

  TextEditingController get titleEditingController => _titleEditingController;

  TextEditingController get categoryEditingController =>
      _categoryEditingController;

  TextEditingController get textEditingController => _textEditingController;

  set setTitleEditingController(String value) {
    _titleEditingController.value = TextEditingValue(
      text: value,
      selection:
          TextSelection(baseOffset: value.length, extentOffset: value.length),
    );
    notifyListeners();
  }

  set setCategoryEditingController(String value) {
    _categoryEditingController.value = TextEditingValue(
      text: value,
      selection:
          TextSelection(baseOffset: value.length, extentOffset: value.length),
    );
    notifyListeners();
  }

  set setTextEditingController(String value) {
    _textEditingController.value = TextEditingValue(
      text: value,
      selection:
          TextSelection(baseOffset: value.length, extentOffset: value.length),
    );
    notifyListeners();
  }

  Future<void> initControllers(
      String title, String category, String text) async {
    _titleEditingController =
        TextEditingController.fromValue(TextEditingValue(text: title));
    _categoryEditingController =
        TextEditingController.fromValue(TextEditingValue(text: category));
    _textEditingController =
        TextEditingController.fromValue(TextEditingValue(text: text));
  }

  void controllerClear() {
    titleEditingController.clear();
    categoryEditingController.clear();
    textEditingController.clear();
    notifyListeners();
  }

  void controllerDispose() {
    titleEditingController.dispose();
    categoryEditingController.dispose();
    textEditingController.dispose();
    notifyListeners();
  }
}
