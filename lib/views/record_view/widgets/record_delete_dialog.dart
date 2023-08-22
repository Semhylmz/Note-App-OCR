import 'package:flutter/material.dart';
import 'package:noteapp/notifier/recorder_notifier.dart';
import 'package:provider/provider.dart';
import '../../../constants/color_constants.dart';
import '../../../notifier/theme_notifier.dart';

class RecordDeleteDialog extends StatelessWidget {
  const RecordDeleteDialog({
    super.key,
    required this.path,
    required this.isTemp,
    required this.name,
  });

  final String path;
  final bool isTemp;
  final String name;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:
          context.watch<ThemeNotifier>().isLight ? mWhiteColor : mBlackColor,
      title: Text("'$name' isimli sesli not silinecek"),
      content: const Text('Emin misiniz?'),
      actions: [
        TextButton(
          onPressed: () async {
            await Provider.of<RecorderNotifier>(context, listen: false)
                .deleteRecord(isTemp: isTemp, path: path)
                .then(
                  (_) => Navigator.of(context).pop(),
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
      ],
    );
  }
}
