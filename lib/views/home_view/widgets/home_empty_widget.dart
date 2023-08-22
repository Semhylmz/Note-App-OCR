import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    required this.isLight,
    required this.text,
  });

  final bool isLight;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset(
            'assets/notes-document.json',
            repeat: false,
            height: MediaQuery.of(context).size.width * 0.5,
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          const SizedBox(height: 8.0),
          Text(
            text,
            style: TextStyle(
              fontSize: 22.0,
              color: isLight
                  ? Colors.black.withOpacity(0.5)
                  : Colors.white.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}
