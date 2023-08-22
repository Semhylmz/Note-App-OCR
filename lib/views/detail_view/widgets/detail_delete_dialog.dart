import 'package:flutter/material.dart';
import 'package:noteapp/constants/color_constants.dart';
import 'package:provider/provider.dart';
import '../../../notifier/note_notifier.dart';
import '../../../notifier/theme_notifier.dart';
import '../../home_view/home_view.dart';

Future<dynamic> detailDeleteDialog(
    BuildContext context, String id, bool isLight) {
  return showDialog(
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.7),
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: isLight ? mWhiteColor : mBlackColor,
      title: const Text('Not silinecek!'),
      content: const Text('Emin misiniz?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Vazgeç',
            style: TextStyle(
                color: context.watch<ThemeNotifier>().isLight
                    ? Colors.black
                    : Colors.white),
          ),
        ),
        TextButton(
          onPressed: () {
            Provider.of<NoteNotifier>(context, listen: false)
                .remove(int.parse(id));

            //ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(msg: 'Deleted', milliSec: 2000));

            Navigator.of(context).pop();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          },
          child: Text(
            'Sil',
            style: TextStyle(
                color: context.watch<ThemeNotifier>().isLight
                    ? Colors.black
                    : Colors.white),
          ),
        ),
      ],
    ),
  );
}
