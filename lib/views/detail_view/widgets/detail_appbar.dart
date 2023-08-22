import 'package:flutter/material.dart';
import 'package:noteapp/notifier/note_text_controller_notifier.dart';
import '../../../constants/color_constants.dart';
import 'buttons/check_button.dart';
import 'buttons/color_button.dart';
import 'buttons/copy_button.dart';
import 'buttons/delete_button.dart';

AppBar detailAppbar(
  BuildContext context,
  bool isLight,
  String color,
  String id,
  bool isFirst,
  String date,
  NoteTextControllerNotifier value,
) {
  return AppBar(
    elevation: 0.3,
    leading: IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icon(Icons.arrow_back_outlined,
          color: isLight ? mBlackOpacityColor : mWhiteOpacityColor),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: Row(
          children: [
            colorButton(context, isLight, color),
            copyButton(context, isLight, value.textEditingController,
                value.titleEditingController),
            deleteButton(context, isLight, value.textEditingController,
                value.titleEditingController, id),
            CheckButton(
              context: context,
              isLight: isLight,
              textEditingController: value.textEditingController,
              titleEditingController: value.titleEditingController,
              categoryEditingController: value.categoryEditingController,
              id: id,
              isFirst: isFirst,
              date: date,
              color: color,
            ),
          ],
        ),
      ),
    ],
  );
}
