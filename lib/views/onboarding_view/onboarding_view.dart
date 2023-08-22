import 'package:flutter/material.dart';
import 'package:noteapp/constants/color_constants.dart';
import 'package:noteapp/notifier/recorder_notifier.dart';
import 'package:noteapp/views/onboarding_view/widgets/on_boarding_content.dart';
import 'package:provider/provider.dart';
import '../../constants/on_board_list.dart';
import '../../notifier/encrypter_key_notifier.dart';
import '../../notifier/onboarding_notifier.dart';
import '../../service/local_auth_service.dart';
import 'widgets/build_dot_button.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage>
    with SingleTickerProviderStateMixin {
  late PageController controller;
  bool isCompleted = false;
  int _pageIndex = 0;

  @override
  void initState() {
    controller = PageController(initialPage: 0);
    initKeys();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> initKeys() async {
    await Provider.of<EncrypterKeyNotifier>(context, listen: false)
        .saveDbKeys()
        .then((_) => LocalAuthService().setIsPassword(value: false).then(
              (_) => Provider.of<OnBoardingNotifier>(context, listen: false)
                  .saveOnboardData(value: 1),
            ))
        .then((_) => Provider.of<RecorderNotifier>(context, listen: false)
            .configRecorderCounter());
    setState(() {
      isCompleted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mWhiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: onboardList.length,
                  controller: controller,
                  onPageChanged: (idx) {
                    setState(() => _pageIndex = idx);
                  },
                  itemBuilder: (context, idx) => OnBoardingContent(idx: idx),
                ),
              ),
              BuildDotButton(
                  pageIndex: _pageIndex,
                  controller: controller,
                  isCompleted: isCompleted),
            ],
          ),
        ),
      ),
    );
  }
}
