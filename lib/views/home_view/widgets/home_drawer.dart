import 'package:flutter/material.dart';
import 'package:noteapp/views/home_view/widgets/drawer/about_list_tile.dart';
import 'package:noteapp/views/home_view/widgets/drawer/theme_list_tile.dart';
import 'package:provider/provider.dart';
import '../../../constants/color_constants.dart';
import '../../../notifier/theme_notifier.dart';
import 'drawer/backup_list_tile.dart';
import 'drawer/bimetric_auth_list_tile.dart';
import 'drawer/grid_view_list_tile.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(32.0),
            bottomRight: Radius.circular(32.0),
          ),
        ),
        backgroundColor:
            context.watch<ThemeNotifier>().isLight ? mWhiteColor : mBlackColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const ThemeListTile(),
              const GridViewListTile(),
              const BiometricListTile(),
              const BackupListTile(),
              InfoListTile(context: context),
            ],
          ),
        ),
      ),
    );
  }
}
