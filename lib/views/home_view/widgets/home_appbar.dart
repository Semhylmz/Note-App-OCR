import 'package:flutter/material.dart';
import 'package:noteapp/constants/color_constants.dart';
import '../../../notifier/note_notifier.dart';
import '../../../widgets/appbar_text.dart';
import 'home_appbar_search_delegate.dart';

AppBar homeAppbar(bool isLight, BuildContext context,
    TabController tabController, NoteNotifier noteNotifier) {
  return AppBar(
    automaticallyImplyLeading: true,
    elevation: 0.0,
    iconTheme:
        IconThemeData(color: isLight ? mBlackOpacityColor : mWhiteOpacityColor),
    title: AppBarText(title: 'Notlarım', context: context),
    actions: [
      IconButton(
        onPressed: () {
          showSearch(
            context: context,
            delegate: CustomSearchDelegate(
              noteNotifier: noteNotifier,
            ),
          );
        },
        icon: Icon(
          Icons.search_rounded,
          color: isLight ? mBlackOpacityColor : mWhiteOpacityColor,
        ),
      ),
    ],
    bottom: TabBar(
      controller: tabController,
      physics: const BouncingScrollPhysics(),
      indicatorPadding: const EdgeInsets.all(8.0),
      tabs: [
        Tab(
            icon: Icon(Icons.sticky_note_2_outlined,
                color: isLight ? mBlackOpacityColor : mWhiteOpacityColor)),
        Tab(
            icon: Icon(Icons.audio_file_outlined,
                color: isLight ? mBlackOpacityColor : mWhiteOpacityColor)),
      ],
    ),
  );
}
