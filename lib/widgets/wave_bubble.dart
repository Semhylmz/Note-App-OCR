import 'dart:async';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/views/record_view/widgets/record_delete_dialog.dart';
import '../constants/color_constants.dart';

class WaveBubble extends StatefulWidget {
  final int? idx;
  final String? path;
  final double? width;
  final bool isLight;
  final String recordName;
  final bool isTemp;

  const WaveBubble({
    Key? key,
    this.width,
    this.idx,
    this.path,
    required this.isLight,
    required this.recordName,
    required this.isTemp,
  }) : super(key: key);

  @override
  State<WaveBubble> createState() => _WaveBubbleState();
}

class _WaveBubbleState extends State<WaveBubble> {
  late PlayerController controller;
  late StreamSubscription<PlayerState> playerStateSubscription;

  final playerWaveStyle = const PlayerWaveStyle(
    fixedWaveColor: Colors.white54,
    liveWaveColor: Colors.white,
    spacing: 7,
  );

  @override
  void initState() {
    super.initState();
    controller = PlayerController();
    _preparePlayer();
    playerStateSubscription = controller.onPlayerStateChanged.listen((_) {
      setState(() {});
    });
  }

  void _preparePlayer() async {
    if (widget.idx == null && widget.path == null) {
      return;
    }
    controller.preparePlayer(
      path: widget.path ?? '',
      shouldExtractWaveform: widget.idx?.isEven ?? true,
    );
    if (widget.idx?.isOdd ?? false) {
      controller
          .extractWaveformData(
            path: widget.path ?? '',
            noOfSamples:
                playerWaveStyle.getSamplesForWidth(widget.width ?? 200),
          )
          .then((waveformData) => debugPrint(waveformData.toString()));
    }
  }

  @override
  void dispose() {
    playerStateSubscription.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.path != null
        ? Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.only(
                  bottom: 6.0, right: 10.0, left: 10.0, top: 6.0),
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: widget.isLight
                    ? Colors.black.withOpacity(0.1)
                    : Colors.white.withOpacity(0.1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.recordName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!controller.playerState.isStopped)
                        IconButton(
                          color: Colors.white,
                          splashColor: mGreen,
                          highlightColor: mOrange,
                          onPressed: () async {
                            controller.playerState.isPlaying
                                ? await controller.pausePlayer()
                                : await controller.startPlayer(
                                    finishMode: FinishMode.pause,
                                  );
                          },
                          icon: Icon(
                            controller.playerState.isPlaying
                                ? Icons.stop
                                : Icons.play_arrow,
                            color: widget.isLight ? mBlackColor : mWhiteColor,
                          ),
                        ),
                      AudioFileWaveforms(
                        size:
                            Size(MediaQuery.of(context).size.width * 0.5, 70.0),
                        playerController: controller,
                        waveformType: widget.idx?.isOdd ?? false
                            ? WaveformType.fitWidth
                            : WaveformType.long,
                        playerWaveStyle: PlayerWaveStyle(
                          fixedWaveColor:
                              widget.isLight ? Colors.white70 : Colors.white54,
                          seekLineColor: mRed,
                          liveWaveColor: mBlackColor,
                          spacing: 7,
                        ),
                      ),
                      IconButton(
                        color: Colors.white,
                        splashColor: mGreen,
                        highlightColor: mOrange,
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (context) => RecordDeleteDialog(
                              name: widget.recordName,
                              path: widget.path!,
                              isTemp: widget.isTemp,
                            ),
                          );
                          setState(() {});
                        },
                        icon: Icon(Icons.delete_forever_rounded,
                            color: widget.isLight ? mBlackColor : mWhiteColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
