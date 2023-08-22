import 'package:flutter/material.dart';
import 'package:noteapp/notifier/note_view_notifier.dart';
import 'package:noteapp/views/home_view/widgets/drawer/drawer_list_tile.dart';
import 'package:provider/provider.dart';

class GridViewListTile extends StatelessWidget {
  const GridViewListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteViewNotifier>(
      builder: (context, value, child) => InkWell(
        onTap: () => value.changeAxisCount(),
        child: DrawerListTile(
            title: 'Görünüm',
            icon: value.crossAxisCount == 1
                ? Icons.grid_view_outlined
                : Icons.view_agenda_outlined),
      ),
    );
  }
}
