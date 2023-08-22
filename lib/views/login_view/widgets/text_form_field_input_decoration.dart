import 'package:flutter/material.dart';
import '../../../constants/color_constants.dart';

InputDecoration buildTextFormFieldDecoration({required String hintText}) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(22.0),
      borderSide: const BorderSide(color: mBlue),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(22.0),
      borderSide: const BorderSide(color: Colors.white),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(22.0),
      borderSide: const BorderSide(color: Colors.white),
    ),
  );
}
