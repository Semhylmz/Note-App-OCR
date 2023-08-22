import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noteapp/views/login_view/widgets/forgot_password_text.dart';
import 'package:noteapp/views/login_view/widgets/text_form_field_input_decoration.dart';
import 'package:noteapp/views/login_view/widgets/login_info.dart';
import '../../constants/color_constants.dart';
import 'widgets/login_background.dart';
import 'widgets/m_button.dart';
import 'widgets/m_title.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  final passwordController = TextEditingController();

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
                  const MTitle(title: 'Giriş Yap'),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const LoginInfo(),
                                      const SizedBox(height: 12.0),
                                      TextFormField(
                                        controller: passwordController,
                                        obscureText: true,
                                        cursorColor: Colors.white,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w500),
                                        decoration: buildTextFormFieldDecoration(
                                            hintText: 'Şifre'),
                                      ),
                                      const SizedBox(height: 12.0),
                                      const MButton(text: "Giriş yap"),
                                      const SizedBox(height: 12.0),
                                      ForgotPasswordText(
                                          context: context, formKey: _formKey),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
