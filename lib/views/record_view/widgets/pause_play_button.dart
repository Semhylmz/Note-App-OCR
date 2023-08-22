import 'package:flutter/material.dart';
import '../../../constants/color_constants.dart';
import '../../../notifier/recorder_notifier.dart';

class PausePlayButton extends StatelessWidget {
  const PausePlayButton({
    super.key,
    required this.recorder,
  });

  final RecorderNotifier recorder;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: recorder.isRecording,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: recorder.isPause ? mGreen : mBlackColor,
              border: Border.all(
                  color: recorder.isPause ? Colors.transparent : mRed),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              color: mWhiteColor,
              iconSize: MediaQuery.of(context).size.width * 0.1,
              icon: Icon(
                recorder.isPause
                    ? Icons.play_arrow_rounded
                    : Icons.pause_rounded,
              ),
              onPressed: () async {
                recorder.isPause
                    ? recorder.resumeRecord()
                    : recorder.pauseRecord();
              },
            ),
          ),
        ],
      ),
    );
  }
}
