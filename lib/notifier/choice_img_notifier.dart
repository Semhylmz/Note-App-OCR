import 'package:flutter/cupertino.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ChoiceImgNotifier extends ChangeNotifier {
  bool _getImg = false;
  bool _isScanning = false;
  XFile? _imgFile;
  String _scannedText = '';

  bool get getImg => _getImg;

  bool get isScanning => _isScanning;

  XFile? get imgFile => _imgFile;

  String get scannedText => _scannedText;

  void changeScanning() {
    _isScanning = !_isScanning;
    notifyListeners();
  }

  set setImgFile(final value) {
    _imgFile = value;
    notifyListeners();
  }

  Future<void> getImage(ImageSource imgSource) async {
    try {
      final pickImage = await ImagePicker().pickImage(source: imgSource);
      if (pickImage != null) {
        _getImg = true;
        _imgFile = pickImage;
        _imgFile = await _cropImage(_imgFile!);
        _getImg = false;
      }
    } catch (e) {
      _getImg = false;
      _imgFile = null;
    }
    notifyListeners();
  }

  Future<XFile?> _cropImage(XFile img) async {
    CroppedFile? croppedImage = await ImageCropper()
        .cropImage(sourcePath: img.path, aspectRatioPresets: [
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio5x3,
      CropAspectRatioPreset.ratio5x4,
      CropAspectRatioPreset.ratio7x5,
      CropAspectRatioPreset.ratio16x9,
    ]);
    if (croppedImage == null) return null;
    notifyListeners();

    return XFile(croppedImage.path);
  }

  Future<void> getRecognizer(XFile img, bool? isList) async {
    changeScanning();

    final selectedImage = InputImage.fromFilePath(img.path);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    RecognizedText recognizedText =
        await textRecognizer.processImage(selectedImage);
    await textRecognizer.close();
    _scannedText = '';

    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        isList!
            ? _scannedText = '$_scannedText\n${line.text}'
            : _scannedText = '$_scannedText ${line.text}';
      }
    }

    changeScanning();
  }
}
