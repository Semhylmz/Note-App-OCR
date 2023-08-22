import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:noteapp/constants/color_constants.dart';
import 'package:provider/provider.dart';
import '../../../notifier/choice_img_notifier.dart';
import '../../../notifier/theme_notifier.dart';
import '../../home_view/widgets/buttons/get_img_button.dart';

class ImgContainer extends StatelessWidget {
  const ImgContainer({
    super.key,
    required this.value,
  });

  final ChoiceImgNotifier value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.file(File(value.imgFile!.path)),
            Visibility(
                visible: value.imgFile!.path.isNotEmpty && value.isScanning
                    ? true
                    : false,
                child: LottieBuilder.asset('assets/scan_img.json')),
            Visibility(
              visible: value.imgFile!.path.isNotEmpty && !value.isScanning
                  ? true
                  : false,
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                      bottomRight: Radius.circular(32.0),
                    ),
                    color: Colors.black.withOpacity(0.5),
                  ),
                  child: IconButton(
                    onPressed: () {
                      value.setImgFile = null;
                      showModalBottomSheet(
                        context: context,
                        backgroundColor:
                            Provider.of<ThemeNotifier>(context, listen: false)
                                    .isLight
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
                                  title: 'Kamera',
                                  icon: Icons.camera_alt_outlined),
                              GetImgButton(
                                  title: 'Galeri', icon: Icons.image_outlined),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      size: 32,
                      Icons.delete_forever_outlined,
                      color: mRed,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
