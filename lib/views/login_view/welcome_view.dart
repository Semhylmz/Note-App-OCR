import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noteapp/views/login_view/widgets/text_form_field_input_decoration.dart';
import 'package:noteapp/views/login_view/widgets/login_background.dart';
import 'package:noteapp/views/login_view/widgets/welcome_divider.dart';
import 'package:noteapp/views/login_view/widgets/m_title.dart';
import 'package:noteapp/views/login_view/widgets/login_google_button.dart';
import 'package:noteapp/views/login_view/widgets/m_button.dart';
import 'package:noteapp/views/login_view/widgets/sign_up_text.dart';
import '../../constants/color_constants.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final emailController = TextEditingController();

  final double _sigmaX = 5.0;
  final double _sigmaY = 5.0;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarColor: Color(0xFF00adff),
          systemNavigationBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(decoration: BoxDecoration(gradient: splashGradient)),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MTitle(title: 'Merhaba!'),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  ClipRect(
                    child: BackdropFilter(
                      filter:
                          ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 32.0),
                          child: Form(
                            key: _formKey,
                            child: Center(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  const LoginBackGround(
                                      imgPath: 'assets/note.png'),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextFormField(
                                        controller: emailController,
                                        obscureText: false,
                                        cursorColor: Colors.white,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w500),
                                        decoration: buildTextFormFieldDecoration(
                                            hintText: 'Email'),
                                      ),
                                      const SizedBox(height: 12.0),
                                      const MButton(text: "Devam et"),
                                      const SizedBox(height: 12.0),
                                      const WelcomeDivider(),
                                      const SizedBox(height: 12.0),
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            LoginGoogleButton(
                                                iconPath:
                                                    'assets/google_icon.png'),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 12.0),
                                      SignUpText(context: context),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
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
