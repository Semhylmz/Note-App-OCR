import 'package:flutter/material.dart';
import 'package:noteapp/extension/get_date_now.dart';
import 'package:provider/provider.dart';
import '../../../../constants/color_constants.dart';
import '../../../../model/note_db_model.dart';
import '../../../../notifier/note_color_notifier.dart';
import '../../../../notifier/note_notifier.dart';
import '../../../home_view/home_view.dart';
import '../detail_save_dialog.dart';

class CheckButton extends StatelessWidget {
  const CheckButton(
      {Key? key,
      required this.context,
      required this.isLight,
      required this.textEditingController,
      required this.titleEditingController,
      required this.categoryEditingController,
      required this.id,
      required this.isFirst,
      required this.date,
      required this.color})
      : super(key: key);

  final BuildContext context;
  final bool isLight;
  final TextEditingController textEditingController;
  final TextEditingController titleEditingController;
  final TextEditingController categoryEditingController;
  final String id;
  final bool isFirst;
  final String date;
  final String color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        textEditingController.text.isEmpty &&
                titleEditingController.text.isEmpty &&
                categoryEditingController.text.isEmpty
            ? saveDialog(
                context,
                NoteDbModel(
                    title: '',
                    content: '',
                    category: '',
                    date: date,
                    color: color),
                isLight,
                isFirst,
                isFirst ? null : int.parse(id))
            : await Provider.of<NoteNotifier>(context, listen: false)
                .addUpdate(
                    NoteDbModel(
                        title: titleEditingController.value.text,
                        content: textEditingController.value.text,
                        category: categoryEditingController.value.text,
                        date: context.dateNow,
                        color: color),
                    isFirst,
                    isFirst ? null : int.parse(id))
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
      icon: Icon(
          context.watch<NoteNotifier>().isProcessing
              ? Icons.hourglass_top_outlined
              : Icons.check,
          color: isLight ? mBlackOpacityColor : mWhiteOpacityColor,
          size: 22.0),
    );
  }
}
