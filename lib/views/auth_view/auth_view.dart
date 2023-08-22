import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../constants/color_constants.dart';
import '../../service/local_auth_service.dart';
import '../home_view/home_view.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  void initState() {
    super.initState();
    initAuth();
  }

  Future<void> initAuth() async {
    await LocalAuthService.authenticate()
        ? Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false)
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          LottieBuilder.asset('assets/auth_security.json'),
          Container(
            decoration: BoxDecoration(
                gradient: authGradient,
                borderRadius: BorderRadius.circular(32)),
            child: ElevatedButton(
              onPressed: () async {
                await initAuth();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(32),
                  ),
                ),
              ),
              child: const Text(
                'Tekrar Dene',
                style: TextStyle(
                  color: mWhiteColor,
                  fontSize: 22.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
