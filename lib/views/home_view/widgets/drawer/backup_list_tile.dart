import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../constants/color_constants.dart';
import 'drawer_list_tile.dart';

class BackupListTile extends StatelessWidget {
  const BackupListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Fluttertoast.showToast(
        msg: 'Yedekleme özelliği henüz aktif değil',
        backgroundColor: mRed,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
      ),
      child: const DrawerListTile(
        title: 'Notları yedekle',
        icon: Icons.cloud_upload_outlined,
      ),
    );
  }
}
