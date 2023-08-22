import 'package:flutter/material.dart';
import 'package:noteapp/views/login_view/sign_up_view.dart';
import '../../../constants/color_constants.dart';

class SignUpText extends StatelessWidget {
  const SignUpText({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          'Hesabınız yok mu?',
          style: TextStyle(color: Colors.white, fontSize: 18.0),
          textAlign: TextAlign.start,
        ),
        const SizedBox(width: 4.0),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SignUpPage(),
              ),
            );
          },
          child: const Text(
            'Kayıt Olun',
            style: TextStyle(
              color: mGreen,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
        ),
      ],
    );
  }
}
