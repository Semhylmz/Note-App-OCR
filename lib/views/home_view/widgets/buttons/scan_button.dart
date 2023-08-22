import 'package:flutter/material.dart';
import 'package:noteapp/constants/color_constants.dart';
import 'package:provider/provider.dart';
import '../../../../notifier/choice_img_notifier.dart';
import '../../../detail_view/detail_view.dart';

Container scanButton(
    BuildContext context, ChoiceImgNotifier value, bool isList) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 5.0),
    padding: const EdgeInsets.only(top: 10.0),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: value.isScanning == true ? mGreen : Colors.grey,
        backgroundColor: Colors.white,
        shadowColor: Colors.grey[400],
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      onPressed: () async {
        value.isScanning == false && value.scannedText != null
            ? await Provider.of<ChoiceImgNotifier>(context, listen: false)
                .getRecognizer(value.imgFile!, isList)
                .then(
                  (_) => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailView(
                        id: '',
                        title: '',
                        category: '',
                        text: value.scannedText,
                        isFirst: true,
                      ),
                    ),
                  ),
                )
            : showDialog(
                context: context,
                builder: (context) {
                  return const AlertDialog(
                    title: Text('Metin algılanmadı'),
                    content: Text('Lütfen farklı bir görüntü seçin..'),
                  );
                },
              );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(value.isScanning == true ? Icons.scale_outlined : Icons.check,
                color: value.isScanning ? mGreen : mRed),
            Text(
              value.isScanning == true ? 'Görüntü Taranıyor' : 'Görüntüyü Tara',
              style: TextStyle(
                  fontSize: 13.0,
                  color: value.isScanning == true ? mGreen : Colors.grey[600]),
            )
          ],
        ),
      ),
    ),
  );
}
