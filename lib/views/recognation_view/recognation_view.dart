import 'package:flutter/material.dart';
import 'package:noteapp/constants/color_constants.dart';
import 'package:noteapp/notifier/choice_img_notifier.dart';
import 'package:noteapp/notifier/theme_notifier.dart';
import 'package:noteapp/views/recognation_view/widgets/img_container.dart';
import 'package:provider/provider.dart';
import '../../widgets/appbar_text.dart';
import '../home_view/widgets/buttons/scan_button.dart';
import 'widgets/no_image.dart';

class RecognizerPage extends StatefulWidget {
  const RecognizerPage({Key? key}) : super(key: key);

  @override
  State<RecognizerPage> createState() => _RecognizerPageState();
}

class _RecognizerPageState extends State<RecognizerPage> {
  bool _isList = false;

  @override
  Widget build(BuildContext context) {
    bool isLight = Provider.of<ThemeNotifier>(context, listen: false).isLight;

    return Consumer<ChoiceImgNotifier>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          elevation: 0.3,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_outlined,
                color: isLight ? mBlackOpacityColor : mWhiteOpacityColor),
          ),
          title: AppBarText(
            title: 'Görüntüden metin tarama',
            context: context,
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (value.getImg)
                    const Center(child: CircularProgressIndicator()),
                  if (!value.getImg && value.imgFile == null)
                    Center(child: noImageContainer(isLight)),
                  const SizedBox(height: 20.0),
                  if (value.imgFile != null) ImgContainer(value: value),
                  value.imgFile == null
                      ? const Center(child: SizedBox(height: 0.0, width: 0.0))
                      : Column(
                          children: [
                            const SizedBox(height: 22.0),
                            CheckboxListTile(
                              title: const Text('Görüntüde bir liste var mı?'),
                              subtitle: const Text(
                                  'Görüntüdeki cümleleri satır satır kaydetmek için bu seçeneği seçin.'),
                              controlAffinity: ListTileControlAffinity.platform,
                              value: _isList,
                              checkColor: mGreen,
                              activeColor: Colors.transparent,
                              onChanged: (bool? val) {
                                setState(() {
                                  _isList = val!;
                                });
                              },
                            ),
                            const SizedBox(height: 22.0),
                            scanButton(context, value, _isList),
                          ],
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
