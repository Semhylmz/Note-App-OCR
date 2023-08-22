import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

extension GetDateNow on BuildContext {
  String get dateNow => DateFormat('dd MMMM yyyy/HH:mm',
          Platform.localeName.isEmpty ? 'tr_TR' : Platform.localeName)
      .format(DateTime.now());
}

extension GetDateNowSplit on BuildContext {
  int get dateSlashIdx => dateNow.indexOf("/");
}
