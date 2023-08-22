import 'package:flutter/material.dart';

class LoginInfo extends StatelessWidget {
  const LoginInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.grey[200],
          radius: 22.0,
          child: const Icon(Icons.person_outline, size: 38.0),
        ),
        const SizedBox(width: 12.0),
        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Semih Yılmaz',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                ),
                textAlign: TextAlign.start),
            Text('semh-ylmz@hotmail.com',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.start),
          ],
        ),
      ],
    );
  }
}
