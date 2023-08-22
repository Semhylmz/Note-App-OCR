import 'package:flutter/material.dart';
import '../../../record_view/voice_recorder_view.dart';

class VoiceButton extends StatelessWidget {
  const VoiceButton({
    super.key,
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        title.contains('Sesli Not')
            ? Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const VoiceRecorderPage(),
                ),
              )
            : null;
      },
    );
  }
}
