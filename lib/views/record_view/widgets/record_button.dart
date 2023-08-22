import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:noteapp/notifier/recorder_notifier.dart';
import 'package:noteapp/notifier/theme_notifier.dart';
import 'package:noteapp/views/record_view/widgets/info_area.dart';
import '../../../constants/color_constants.dart';

class RecordButton extends StatelessWidget {
  const RecordButton({
    super.key,
    required this.recorder,
    required this.theme,
  });

  final RecorderNotifier recorder;
  final ThemeNotifier theme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Visibility(
            maintainState: true,
            visible: recorder.isRecording,
            child: Lottie.asset('assets/recording_animation.json'),
          ),
          Container(
            decoration: BoxDecoration(
              color: mRed,
              boxShadow: [
                BoxShadow(
                    color: mRed,
                    blurRadius: recorder.isRecording ? 0.0 : 32.0,
                    spreadRadius: recorder.isRecording ? 0.0 : 8.0),
              ],
              border: Border.all(color: mRed.withOpacity(0.5)),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              color: mWhiteColor,
              iconSize: MediaQuery.of(context).size.width * 0.3,
              icon: Icon(
                recorder.isRecording
                    ? Icons.stop_rounded
                    : Icons.keyboard_voice_outlined,
              ),
              onPressed: () async {
                recorder.isRecording
                    ? recorder.stopRecord()
                    : recorder.startRecord();
              },
            ),
          ),
        ],
      ),
    );
  }
}
