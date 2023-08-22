import 'package:flutter/material.dart';

class MBottomSheet extends StatelessWidget {
  const MBottomSheet({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 24.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12.0),
            Text(content, style: const TextStyle(fontSize: 18.0)),
          ],
        ),
      ),
    );
  }
}
