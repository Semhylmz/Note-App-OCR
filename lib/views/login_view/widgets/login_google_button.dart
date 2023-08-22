import 'package:flutter/material.dart';

class LoginGoogleButton extends StatelessWidget {
  const LoginGoogleButton({
    super.key,
    required this.iconPath,
  });

  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(8.0),
        backgroundColor: Colors.grey[200],
      ),
      child: Image.asset(
        iconPath,
        height: 32.0,
        width: 32.0,
      ),
    );
  }
}
