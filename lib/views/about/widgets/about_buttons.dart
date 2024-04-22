import 'package:flutter/material.dart';
import 'package:noteapp/notifier/theme_notifier.dart';
import 'package:provider/provider.dart';
import '../../../constants/color_constants.dart';

class AboutButton extends StatelessWidget {
  const AboutButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => onTap(),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.all(12),
        side: BorderSide(
          color: context.watch<ThemeNotifier>().isLight
              ? mBlackOpacityColor
              : mWhiteOpacityColor,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              color: context.watch<ThemeNotifier>().isLight
                  ? mBlackOpacityColor
                  : mWhiteOpacityColor,
            ),
          ),
          Icon(
            icon,
            color: context.watch<ThemeNotifier>().isLight
                ? mBlackOpacityColor
                : mWhiteOpacityColor,
          ),
        ],
      ),
    );
  }
}
