import 'package:flutter/material.dart';
import 'package:noteapp/model/note_db_model.dart';
import 'package:provider/provider.dart';
import '../../../constants/color_constants.dart';
import '../../../notifier/note_color_notifier.dart';
import '../../../notifier/note_notifier.dart';
import '../../../notifier/theme_notifier.dart';
import '../../home_view/home_view.dart';

Future<dynamic> saveDialog(BuildContext context, NoteDbModel noteDbModel,
    bool isLight, bool isFirst, int? id) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: isLight ? mWhiteColor : mBlackColor,
        title: const Text('Herhangi bir içerik eklemediniz'),
        content: const Text('Kayıt etmek istiyor musunuz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Vazgeç',
              style: TextStyle(
                  color: context.watch<ThemeNotifier>().isLight
                      ? Colors.black
                      : Colors.white),
            ),
          ),
          TextButton(
            onPressed: () async {
              await Provider.of<NoteNotifier>(context, listen: false)
                  .addUpdate(noteDbModel, isFirst, id)
                  .then((_) =>
                      Provider.of<NoteColorNotifier>(context, listen: false)
                          .defaultColor())
                  .then(
                    (_) => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HomePage(),
                      ),
                    ),
                  );
            },
            child: Text(
              'Kaydet',
              style: TextStyle(
                  color: context.watch<ThemeNotifier>().isLight
                      ? Colors.black
                      : Colors.white),
            ),
          ),
        ],
      );
    },
  );
}
