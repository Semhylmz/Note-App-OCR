import 'package:flutter/material.dart';
import 'package:noteapp/constants/color_constants.dart';
import 'package:provider/provider.dart';
import '../notifier/theme_notifier.dart';

class AppBarText extends StatelessWidget {
  const AppBarText(
      {super.key, required this.title, required BuildContext context});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 24.0,
          color: context.watch<ThemeNotifier>().isLight
              ? mBlackOpacityColor
              : mWhiteOpacityColor),
    );
  }
}
