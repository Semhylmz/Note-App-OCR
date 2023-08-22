import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:noteapp/views/login_view/widgets/text_form_field_input_decoration.dart';
import 'package:noteapp/views/login_view/widgets/login_background.dart';
import 'package:noteapp/views/login_view/widgets/m_button.dart';
import 'package:noteapp/views/login_view/widgets/m_title.dart';
import 'package:noteapp/views/login_view/widgets/sign_up_user_agreement.dart';
import '../../constants/color_constants.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final double _sigmaX = 5.0;
  final double _sigmaY = 5.0;
  final _formKey = GlobalKey<FormState>();

  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  const MTitle(title: 'Kayıt Ol'),
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
                                        decoration:
                                            buildTextFormFieldDecoration(
                                                hintText: 'Email'),
                                      ),
                                      const SizedBox(height: 12.0),
                                      TextFormField(
                                        controller: passwordController,
                                        obscureText: true,
                                        cursorColor: Colors.white,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w500),
                                        decoration:
                                            buildTextFormFieldDecoration(
                                                hintText: 'Şifre'),
                                      ),
                                      const SizedBox(height: 12.0),
                                      const UserAgreement(),
                                      const SizedBox(height: 12.0),
                                      const MButton(text: "Kayıt ol"),
                                    ],
                                  )
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
