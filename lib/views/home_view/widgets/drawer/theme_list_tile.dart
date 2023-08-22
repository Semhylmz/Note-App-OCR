import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../notifier/theme_notifier.dart';
import 'drawer_list_tile.dart';

class ThemeListTile extends StatelessWidget {
  const ThemeListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () =>
            Provider.of<ThemeNotifier>(context, listen: false).changeTheme(),
        child: DrawerListTile(
            title: context.watch<ThemeNotifier>().isLight
                ? 'Koyu Tema'
                : 'Açık Tema',
            icon: context.watch<ThemeNotifier>().isLight
                ? Icons.nightlight_outlined
                : Icons.wb_sunny_outlined));
  }
}
