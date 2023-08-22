import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/color_constants.dart';
import '../../../notifier/note_notifier.dart';
import '../../../notifier/theme_notifier.dart';

class HomeDeleteDialog extends StatelessWidget {
  const HomeDeleteDialog({
    super.key,
    required this.value,
    required this.idx,
  });

  final NoteNotifier value;
  final int idx;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:
          context.watch<ThemeNotifier>().isLight ? mWhiteColor : mBlackColor,
      title: const Text('Not silinecek'),
      content: const Text('Emin misiniz?'),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Vazgeç',
              style: TextStyle(
                  color: context.watch<ThemeNotifier>().isLight
                      ? Colors.black
                      : Colors.white),
            )),
        TextButton(
          onPressed: () async {
            await Provider.of<NoteNotifier>(context, listen: false)
                .remove(value.list[idx].id!.toInt())
                .then((_) => Navigator.of(context).pop());
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
    );
  }
}
