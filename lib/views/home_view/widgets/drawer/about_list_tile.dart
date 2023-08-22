import 'package:flutter/material.dart';
import 'package:noteapp/views/about/about_view.dart';
import 'drawer_list_tile.dart';

class InfoListTile extends StatelessWidget {
  const InfoListTile({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AboutApp(),
          ),
        );
      },
      child: const DrawerListTile(
        title: 'Hakkında',
        icon: Icons.info_outline,
      ),
    );
  }
}
