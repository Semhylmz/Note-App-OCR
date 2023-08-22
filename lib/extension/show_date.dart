import 'package:flutter/material.dart';
import 'package:noteapp/extension/get_date_now.dart';

String showDate(
    {required String dateTemp,
    required BuildContext context,
    required bool isFirst}) {
  final int idx = dateTemp.indexOf("/");

  String date = isFirst
      ? dateTemp.substring(idx + 1, dateTemp.length)
      : context.dateNow
              .substring(0, context.dateSlashIdx)
              .contains(dateTemp.substring(0, idx))
          ? dateTemp.substring(idx + 1, dateTemp.length)
          : dateTemp.substring(0, idx);
  return date;
}
