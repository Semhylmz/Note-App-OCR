import 'package:flutter/material.dart';
import 'package:noteapp/notifier/note_notifier.dart';
import 'package:noteapp/notifier/theme_notifier.dart';
import 'package:provider/provider.dart';
import '../../constants/color_constants.dart';
import '../detail_view/detail_view.dart';
import 'widgets/home_delete_dialog.dart';

Widget homeContent(
    {required NoteNotifier value,
    required BuildContext context,
    required int idx}) {
  return IntrinsicHeight(
    child: Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        border: Border.all(
            color: context.watch<ThemeNotifier>().isLight == true
                ? Colors.black.withOpacity(0.15)
                : Colors.white.withOpacity(0.15)),
        color: context.watch<ThemeNotifier>().isLight == true
            ? mWhiteColor
            : mBlackColor,
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailView(
                value: value,
                id: value.list[idx].id.toString(),
                title: value.list[idx].title,
                text: value.list[idx].content,
                category: value.list[idx].category,
                isFirst: false,
                idx: idx,
              ),
            ),
          );
        },
        onLongPress: () {
          showDialog(
            barrierDismissible: true,
            barrierColor: Colors.black.withOpacity(0.7),
            context: context,
            builder: (context) => HomeDeleteDialog(idx: idx, value: value),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 10.0,
              decoration: BoxDecoration(
                  color: Color(int.parse(value.list[idx].color)),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12.0),
                      topLeft: Radius.circular(12.0))),
            ),
            Flexible(
              child: Container(
                margin: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value.list[idx].title,
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: context.watch<ThemeNotifier>().isLight
                              ? mBlackOpacityColor
                              : mWhiteOpacityColor),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      value.list[idx].content.length <= 300
                          ? value.list[idx].content
                          : value.list[idx].content.substring(0, 150),
                      style: TextStyle(
                          fontSize: 16.0,
                          color: context.watch<ThemeNotifier>().isLight
                              ? mBlackOpacityColor
                              : mWhiteOpacityColor),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
