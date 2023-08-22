import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noteapp/constants/text_constants.dart';
import 'package:noteapp/notifier/choice_img_notifier.dart';
import 'package:noteapp/views/home_view/home_view.dart';
import 'package:provider/provider.dart';
import '../../../../notifier/permission_notifier.dart';
import '../../../recognation_view/recognation_view.dart';

class GetImgButton extends StatelessWidget {
  const GetImgButton({
    super.key,
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () async {
        await PermissionNotifier().checkStoragePermission()
            ? Provider.of<ChoiceImgNotifier>(context, listen: false)
                .getImage(title.contains('Kamera')
                    ? ImageSource.camera
                    : ImageSource.gallery)
                .then(
                  (_) => Provider.of<ChoiceImgNotifier>(context, listen: false)
                              .imgFile !=
                          null
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RecognizerPage(),
                          ),
                        )
                      : Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                          (route) => false,
                        ),
                )
            : Fluttertoast.showToast(msg: storagePermissions);
      },
    );
  }
}
