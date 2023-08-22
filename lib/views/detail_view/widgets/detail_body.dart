import 'package:flutter/material.dart';
import 'package:noteapp/notifier/note_notifier.dart';
import 'package:noteapp/views/detail_view/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';
import '../../../constants/color_constants.dart';
import '../../../notifier/note_text_controller_notifier.dart';

class DetailBody extends StatelessWidget {
  const DetailBody({
    super.key,
    required this.value,
    required this.isLight,
    required this.color,
    required this.date,
    required this.noteNotifier,
  });

  final NoteTextControllerNotifier value;
  final NoteNotifier noteNotifier;
  final bool isLight;
  final String color;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                context.watch<NoteNotifier>().isProcessing
                    ? LinearProgressIndicator(
                        minHeight: 2.0,
                        valueColor: const AlwaysStoppedAnimation(mRed),
                        backgroundColor:
                            isLight ? mBlackOpacityColor : mWhiteOpacityColor)
                    : Container(height: 3.0, color: Color(int.parse(color))),
                TextFieldWidget(
                  value: value,
                  isLight: isLight,
                  controller: value.titleEditingController,
                  textInputAction: TextInputAction.next,
                  hintText: 'Başlık',
                  fontSize: 24.0,
                  callback: (newValue) {
                    value.setTitleEditingController = newValue;
                  },
                ),
                TextFieldWidget(
                  value: value,
                  isLight: isLight,
                  controller: value.categoryEditingController,
                  textInputAction: TextInputAction.next,
                  hintText: 'Kategori',
                  fontSize: 16.0,
                  callback: (String newValue) {
                    value.setCategoryEditingController = newValue;
                  },
                ),
                TextFieldWidget(
                  value: value,
                  isLight: isLight,
                  controller: value.textEditingController,
                  textInputAction: TextInputAction.done,
                  hintText: 'Not',
                  fontSize: 18.0,
                  callback: (newValue) {
                    value.setTextEditingController = newValue;
                  },
                ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
                child: Text(
                  date.length == 5
                      ? 'Düzenleme saati: $date'
                      : 'Düzenleme tarihi: $date',
                  style: TextStyle(
                      fontSize: 12.0,
                      color: isLight == true
                          ? mBlackOpacityColor
                          : mWhiteOpacityColor),
                ),
              ),
            ),
            const SizedBox(height: 4.0),
          ],
        ),
      ],
    );
  }
}
