import 'package:flutter/material.dart';
import '../../../constants/color_constants.dart';

class ForgotPasswordText extends StatelessWidget {
  const ForgotPasswordText({
    super.key,
    required this.context,
    required this.formKey,
  });

  final BuildContext context;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return const Text('Şifremi unuttum',
        style: TextStyle(
          color: mGreen,
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
        textAlign: TextAlign.start);
  }
}
