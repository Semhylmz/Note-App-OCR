import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:noteapp/notifier/auth_notifier.dart';
import 'package:provider/provider.dart';
import '../../../constants/color_constants.dart';

class MButton extends StatelessWidget {
  const MButton({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(
      builder: (context, authValue, child) => Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: splashGradient,
          borderRadius: BorderRadius.circular(22.0),
        ),
        child: ElevatedButton(
          onPressed: () {
            String title = text;
            switch (title) {
              case 'Devam et':
                break;
              case 'Kayıt ol':
                break;
              case 'Giriş yap':
                break;
              default:
                Fluttertoast.showToast(
                    msg: 'Geçersiz işlem', toastLength: Toast.LENGTH_LONG);
            }
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(12.0),
            primary: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22.0),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
