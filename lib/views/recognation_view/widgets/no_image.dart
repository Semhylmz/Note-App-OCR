import 'package:flutter/material.dart';
import 'package:noteapp/constants/color_constants.dart';

Container noImageContainer(bool isLight) {
  return Container(
    width: 300.0,
    height: 300.0,
    decoration: BoxDecoration(
      color: isLight == true
          ? Colors.black.withOpacity(0.1)
          : Colors.white.withOpacity(0.9),
      borderRadius: BorderRadius.circular(32.0),
    ),
    child: Center(
      child: Text(
        'Görüntü seçilmedi veya silindi',
        style: TextStyle(
            fontSize: 24.0,
            color: mBlackOpacityColor.withOpacity(0.5),
            fontWeight: FontWeight.bold),
      ),
    ),
  );
}
