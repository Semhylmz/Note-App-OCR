import 'package:flutter/material.dart';

class MTitle extends StatelessWidget {
  const MTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold),
    );
  }
}
