import 'package:flutter/material.dart';

class WelcomeDivider extends StatelessWidget {
  const WelcomeDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 0.5,
            color: Colors.grey[400],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            'Veya',
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 0.5,
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }
}
