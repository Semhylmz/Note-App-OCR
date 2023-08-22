import 'package:flutter/material.dart';
import 'package:noteapp/views/home_view/home_view.dart';
import '../../../constants/color_constants.dart';
import '../../../notifier/recorder_notifier.dart';
import '../../../widgets/wave_bubble.dart';

class InfoArea extends StatelessWidget {
  const InfoArea({
    super.key,
    required this.recorder,
    required this.isLight,
  });

  final RecorderNotifier recorder;
  final bool isLight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Sesli notunuz',
                maxLines: null,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 22.0),
              ),
              TextButton(
                onPressed: () async {
                  await recorder.saveRecord().then(
                        (value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                          (route) => false,
                        ),
                      );
                },
                child: Text(
                  recorder.isSave ? 'Kayıt ediliyor' : 'Kaydet',
                  style: const TextStyle(fontSize: 22.0, color: mRed),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          TextField(
            controller: recorder.titleEditingController,
            textCapitalization: TextCapitalization.sentences,
            maxLines: null,
            textInputAction: TextInputAction.done,
            onChanged: (newValue) {
              recorder.setRecordName = newValue;
            },
            style: TextStyle(
                fontSize: 18.0,
                color:
                    isLight == true ? mBlackOpacityColor : mWhiteOpacityColor),
            decoration: const InputDecoration(
              hintText: 'Sesli not ismi ekleyebilirsiniz',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
                borderSide: BorderSide(color: mRed, width: 0.0),
              ),
              hintStyle: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal),
            ),
          ),
          const SizedBox(height: 8.0),
          WaveBubble(
            isTemp: true,
            recordName: recorder.tempFileName,
            isLight: isLight,
            path: recorder.tempFilePath,
          ),
        ],
      ),
    );
  }
}
