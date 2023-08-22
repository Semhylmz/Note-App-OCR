import 'package:flutter/material.dart';

class LoginBackGround extends StatelessWidget {
  const LoginBackGround({
    super.key,
    required this.imgPath,
  });

  final String imgPath;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imgPath,
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.5,
      fit: BoxFit.contain,
    );
  }
}
