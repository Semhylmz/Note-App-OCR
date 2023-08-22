import 'package:flutter/material.dart';
import 'package:noteapp/notifier/note_text_controller_notifier.dart';
import 'package:noteapp/views/detail_view/widgets/detail_delete_dialog.dart';
import 'package:provider/provider.dart';
import '../../../../constants/color_constants.dart';
import '../../../../notifier/note_color_notifier.dart';

IconButton deleteButton(
    BuildContext context,
    bool isLight,
    TextEditingController textEditingController,
    TextEditingController titleEditingController,
    String id) {
  return IconButton(
    onPressed: () async {
      id.isEmpty || id == null
          ? Provider.of<NoteTextControllerNotifier>(context, listen: false)
              .controllerClear()
          : detailDeleteDialog(context, id, isLight);

      await Provider.of<NoteColorNotifier>(context, listen: false)
          .defaultColor();
    },
    icon: Icon(
      Icons.delete_outline_outlined,
      color: isLight ? mBlackOpacityColor : mWhiteOpacityColor,
      size: 22.0,
    ),
  );
}
