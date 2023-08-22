import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../notifier/theme_notifier.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
          color: context.watch<ThemeNotifier>().isLight
              ? Colors.black
              : Colors.white,
        ),
      ),
      trailing: Icon(
        icon,
        color: context.watch<ThemeNotifier>().isLight
            ? Colors.black
            : Colors.white,
      ),
    );
  }
}
