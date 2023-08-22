import 'package:flutter/material.dart';
import 'package:noteapp/notifier/recorder_notifier.dart';
import 'package:noteapp/views/home_view/widgets/home_empty_widget.dart';
import 'package:provider/provider.dart';
import '../../notifier/theme_notifier.dart';
import '../../widgets/wave_bubble.dart';

Widget homeVoicePage(
    {required RecorderNotifier recorder, required BuildContext context}) {
  return recorder.recordList.isEmpty
      ? EmptyWidget(
          text: 'Henüz sesli not eklemediniz',
          isLight: context.watch<ThemeNotifier>().isLight)
      : ListView.builder(
          itemCount: recorder.recordList.length,
          itemBuilder: (context, idx) {
            int startValue = recorder.recordList[idx].path
                .lastIndexOf('/', recorder.recordList[idx].path.length);
            int endValue = recorder.recordList[idx].path.length;
            return WaveBubble(
              isTemp: false,
              recordName: recorder.recordList[idx].path
                  .substring(startValue + 1, endValue - 4),
              path: recorder.recordList[idx].path,
              isLight: context.watch<ThemeNotifier>().isLight,
            );
          },
        );
}
