import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noteapp/constants/color_constants.dart';
import 'package:noteapp/notifier/note_view_notifier.dart';
import 'package:noteapp/notifier/recorder_notifier.dart';
import 'package:noteapp/views/auth_view/auth_view.dart';
import 'package:provider/provider.dart';
import '../../config/config.dart';
import '../../notifier/note_notifier.dart';
import '../../service/local_auth_service.dart';
import '../home_view/home_view.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool isOk = false;

  @override
  void initState() {
    setProviders();
    super.initState();
  }

  Future<void> setProviders() async {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    Config.sharedPreferences!.getInt('recorderCounter') == null
        ? Provider.of<RecorderNotifier>(context, listen: false)
            .configRecorderCounter()
        : Provider.of<RecorderNotifier>(context, listen: false)
            .getRecordNameCount();

    Provider.of<LocalAuthService>(context, listen: false).getIsPassword();
    Provider.of<NoteViewNotifier>(context, listen: false).getAxisCount();

    await Provider.of<NoteNotifier>(context, listen: false)
        .getAllData()
        .then((_) =>
            Provider.of<RecorderNotifier>(context, listen: false).getRecords())
        .then((_) => routePage());
  }

  void routePage() {
    Provider.of<LocalAuthService>(context, listen: false).isPassword
        ? Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const AuthPage()),
            (route) => false)
        : Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xFF00f1ff), Color(0xff00adff)],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight),
      ),
      child: Column(
        children: [
          const Spacer(),
          Container(
            height: MediaQuery.of(context).size.width * 0.7,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/note.png'),
                fit: BoxFit.contain,
                alignment: Alignment.center,
                // scale: 0.5,
              ),
            ),
          ),
          const Spacer(),
          const CircularProgressIndicator(
              color: mBlackColor, backgroundColor: Colors.white24),
          const Spacer(),
        ],
      ),
    );
  }
}
