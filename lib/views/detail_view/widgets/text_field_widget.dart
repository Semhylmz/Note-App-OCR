import 'package:flutter/material.dart';
import '../../../constants/color_constants.dart';
import '../../../notifier/note_text_controller_notifier.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.value,
    required this.isLight,
    required this.controller,
    required this.textInputAction,
    required this.hintText,
    required this.fontSize,
    required this.callback,
  });

  final NoteTextControllerNotifier value;
  final bool isLight;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final String hintText;
  final double fontSize;
  final Function(String newValue) callback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: TextField(
        onChanged: (newValue) => callback,
        controller: controller,
        textCapitalization: TextCapitalization.sentences,
        maxLines: null,
        textInputAction: textInputAction,
        style: TextStyle(
          fontSize: 18.0,
          color: isLight == true ? mBlackOpacityColor : mWhiteOpacityColor,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          hintStyle: TextStyle(
            fontSize: fontSize,
            color: Colors.grey,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
