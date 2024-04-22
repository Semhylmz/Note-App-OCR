import 'dart:io';

import 'package:flutter/material.dart';
import 'package:noteapp/views/about/widgets/show_modal_bottom_sheet.dart';
import 'package:noteapp/widgets/appbar_text.dart';
import 'package:provider/provider.dart';
import '../../constants/color_constants.dart';
import '../../constants/text_constants.dart';
import '../../notifier/theme_notifier.dart';
import 'widgets/about_buttons.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText(title: 'Uygulama Hakkında', context: context),
        elevation: 0.0,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: context.watch<ThemeNotifier>().isLight
              ? mBlackOpacityColor
              : mWhiteOpacityColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 11.0),
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  aboutAppContent,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: context.watch<ThemeNotifier>().isLight
                        ? mBlackOpacityColor
                        : mWhiteOpacityColor,
                  ),
                ),
                const SizedBox(height: 24.0),
                Column(
                  children: [
                    AboutButton(
                      title: 'Kullanıcı sözleşmesi',
                      icon: Icons.text_snippet_outlined,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor:
                              Provider.of<ThemeNotifier>(context, listen: false)
                                      .isLight
                                  ? mWhiteColor
                                  : mBlackColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32.0),
                              topRight: Radius.circular(32.0),
                            ),
                          ),
                          builder: (context) => const MBottomSheet(
                            title: 'Kullanıcı sözleşmesi',
                            content: userAgreement,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24.0),
                    AboutButton(
                      title: 'Açık kaynak lisanslar',
                      icon: Icons.code_outlined,
                      onTap: () {
                        showLicensePage(context: context);
                      },
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
