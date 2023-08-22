import 'package:flutter/material.dart';
import 'package:noteapp/notifier/theme_notifier.dart';
import 'package:noteapp/views/about/widgets/show_modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import '../../../constants/color_constants.dart';
import '../../../constants/text_constants.dart';

class AboutButton extends StatelessWidget {
  const AboutButton({
    super.key,
    required this.title,
    required this.icon,
    required this.isLight,
  });

  final String title;
  final IconData icon;
  final bool isLight;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: isLight ? mWhiteColor : mBlackColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32.0),
              topRight: Radius.circular(32.0),
            ),
          ),
          builder: (context) => MBottomSheet(
            title: title.contains('Kullanıcı sözleşmesi')
                ? 'Kullanıcı sözleşmesi'
                : 'Açık kaynak lisanslar',
            content: title.contains('Kullanıcı sözleşmesi')
                ? userAgreement
                : openSourceLicences,
          ),
        );
      },
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
