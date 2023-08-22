import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:noteapp/notifier/recorder_notifier.dart';
import 'package:noteapp/notifier/theme_notifier.dart';
import 'package:noteapp/views/record_view/widgets/info_area.dart';
import 'package:noteapp/views/record_view/widgets/record_button.dart';
import 'package:provider/provider.dart';
import '../../constants/color_constants.dart';
import '../../widgets/appbar_text.dart';

class VoiceRecorderPage extends StatefulWidget {
  const VoiceRecorderPage({Key? key}) : super(key: key);

  @override
  State<VoiceRecorderPage> createState() => _VoiceRecorderVideState();
}

class _VoiceRecorderVideState extends State<VoiceRecorderPage> {
  @override
  void initState() {
    initControllers();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    //disposeController();
  }

  void disposeController() {
    Provider.of<RecorderNotifier>(context, listen: false)
        .disposeTitleController();
  }

  void initControllers() {
    Provider.of<RecorderNotifier>(context, listen: false).initTitleController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          elevation: 0.0,
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(
            color: context.watch<ThemeNotifier>().isLight
                ? mBlackOpacityColor
                : mWhiteOpacityColor,
          ),
          title: AppBarText(title: 'Sesli Not', context: context)),
      body: WillPopScope(
        onWillPop: () async {
          Provider.of<RecorderNotifier>(context, listen: false)
                  .isRecordCompleted
              ? Provider.of<RecorderNotifier>(context, listen: false)
                  .defaultValues()
              : Provider.of<RecorderNotifier>(context, listen: false)
                      .isRecording
                  ? Fluttertoast.showToast(
                      msg: 'Ses kaydı devam ediyor!',
                      backgroundColor: mRed,
                      toastLength: Toast.LENGTH_LONG)
                  : null;
          return Provider.of<RecorderNotifier>(context, listen: false)
                  .isRecording
              ? false
              : true;
        },
        child: Consumer2<ThemeNotifier, RecorderNotifier>(
          builder: (context, theme, recorder, child) => Center(
            child: recorder.isRecordCompleted
                ? InfoArea(recorder: recorder, isLight: theme.isLight)
                : RecordButton(recorder: recorder, theme: theme),
            // child: Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     RecordButton(recorder: recorder, theme: theme),
            //     //PausePlayButton(recorder: recorder),
            //     //InfoArea(recorder: recorder, isLight: theme.isLight),
            //   ],
            // ),
          ),
        ),
      ),
    );
  }
}
