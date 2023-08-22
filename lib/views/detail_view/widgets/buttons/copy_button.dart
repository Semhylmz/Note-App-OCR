import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../constants/color_constants.dart';

IconButton copyButton(
  BuildContext context,
  bool isLight,
  TextEditingController textEditingController,
  TextEditingController titleEditingController,
) {
  return IconButton(
    onPressed: () {
      textEditingController.text.isEmpty && titleEditingController.text.isEmpty
          ? Fluttertoast.showToast(
              msg: 'Kopyalanacak not bulunamadı',
              backgroundColor: mRed,
              toastLength: Toast.LENGTH_LONG)
          : Clipboard.setData(ClipboardData(
                  text:
                      '${titleEditingController.text}\n\n${textEditingController.text}'))
              .then(
              (_) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: const Text('Not kopyalandı!',
                      style: TextStyle(color: Colors.white)),
                  backgroundColor: mRed,
                  duration: const Duration(seconds: 5),
                  action: SnackBarAction(
                    label: ('Paylaş'),
                    textColor: Colors.white,
                    onPressed: () async {
                      ClipboardData? shareContent =
                          await Clipboard.getData(Clipboard.kTextPlain);
                      sharePressed(shareContent!.text.toString());
                    },
                  ),
                ),
              ),
            );
    },
    icon: Icon(Icons.copy_all_outlined,
        color: isLight ? mBlackOpacityColor : mWhiteOpacityColor, size: 22.0),
  );
}

void sharePressed(String content) async {
  await Share.share(content);
}
