import 'package:flutter/material.dart';
import '../../../constants/color_constants.dart';

class UserAgreement extends StatelessWidget {
  const UserAgreement({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kayıt olarak kullanım şartlarını kabul etmiş olursunuz.',
          maxLines: null,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        SizedBox(width: 4.0),
        Text(
          'Kullanım Şartları',
          maxLines: null,
          style: TextStyle(
            color: mGreen,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        )
      ],
    );
  }
}
