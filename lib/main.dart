import 'package:flutter/material.dart';
import 'package:noteapp/config/config.dart';
import 'package:noteapp/notifier/auth_notifier.dart';
import 'package:noteapp/notifier/choice_img_notifier.dart';
import 'package:noteapp/notifier/encrypter_key_notifier.dart';
import 'package:noteapp/notifier/note_color_notifier.dart';
import 'package:noteapp/notifier/note_text_controller_notifier.dart';
import 'package:noteapp/notifier/note_notifier.dart';
import 'package:noteapp/notifier/note_view_notifier.dart';
import 'package:noteapp/notifier/onboarding_notifier.dart';
import 'package:noteapp/notifier/recorder_notifier.dart';
import 'package:noteapp/notifier/theme_notifier.dart';
import 'package:noteapp/service/local_auth_service.dart';
import 'package:noteapp/views/onboarding_view/onboarding_view.dart';
import 'package:noteapp/views/splash_view/splash_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? isFirst;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Config.sharedPreferences = await SharedPreferences.getInstance();
  isFirst = Config.sharedPreferences!.getInt('isFirst');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NoteNotifier()),
        ChangeNotifierProvider(create: (context) => ThemeNotifier()),
        ChangeNotifierProvider(create: (context) => NoteColorNotifier()),
        ChangeNotifierProvider(create: (context) => ChoiceImgNotifier()),
        ChangeNotifierProvider(
            create: (context) => NoteTextControllerNotifier()),
        ChangeNotifierProvider(create: (context) => RecorderNotifier()),
        ChangeNotifierProvider(create: (context) => LocalAuthService()),
        ChangeNotifierProvider(create: (context) => OnBoardingNotifier()),
        ChangeNotifierProvider(create: (context) => EncrypterKeyNotifier()),
        ChangeNotifierProvider(create: (context) => NoteViewNotifier()),
        ChangeNotifierProvider(create: (context) => AuthNotifier()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    Provider.of<ThemeNotifier>(context, listen: false).loadTheme();
    ThemeData themeMode = Provider.of<ThemeNotifier>(context).theme;

    return MaterialApp(
      theme: themeMode,
      debugShowCheckedModeBanner: false,
      home: isFirst == 1 ? const SplashPage() : const OnBoardingPage(),
    );
  }
}
