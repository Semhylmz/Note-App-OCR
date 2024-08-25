import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/color_constants.dart';
import '../../../notifier/recorder_notifier.dart';
import '../../../notifier/theme_notifier.dart';
import '../../record_view/voice_recorder_view.dart';
import 'buttons/get_img_button.dart';

class CustomBottomAppBar extends StatelessWidget {
  const   CustomBottomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: context.watch<ThemeNotifier>().isLight ? mWhiteColor : mBlackColor,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          IconButton(
              onPressed: () async {
                await Provider.of<RecorderNotifier>(context, listen: false)
                    .getTempRecords()
                    .then(
                      (_) => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const VoiceRecorderPage(),
                        ),
                      ),
                    );
              },
              icon: Icon(Icons.mic_none_outlined,
                  color: context.watch<ThemeNotifier>().isLight
                      ? mBlackOpacityColor
                      : mWhiteOpacityColor)),
          IconButton(
              onPressed: () async {
                showModalBottomSheet(
                  context: context,
                  backgroundColor:
                      Provider.of<ThemeNotifier>(context, listen: false).isLight
                          ? mWhiteColor
                          : mBlackColor,
                  useSafeArea: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.0),
                      topRight: Radius.circular(24.0),
                    ),
                  ),
                  builder: (context) {
                    return const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GetImgButton(
                            title: 'Kamera', icon: Icons.camera_alt_outlined),
                        GetImgButton(
                            title: 'Galeri', icon: Icons.image_outlined),
                      ],
                    );
                  },
                );
              },
              icon: Icon(Icons.image_outlined,
                  color: context.watch<ThemeNotifier>().isLight
                      ? mBlackOpacityColor
                      : mWhiteOpacityColor)),
        ],
      ),
    );
  }
}
