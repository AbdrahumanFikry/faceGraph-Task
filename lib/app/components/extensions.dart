import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

extension DateTimeExt on DateTime {
  String toShortUserString() {
    return intl.DateFormat(
      'yyyy-MM-dd',
      const Locale('en', 'US').toString(),
    ).format(this);
  }

  String toLongUserString() {
    return '${intl.DateFormat.yMMMMEEEEd().format(this)} @ ${intl.DateFormat.jm(const Locale('en', 'US').toString()).format(this)}';
  }

  String toNumbersFormat() {
    return intl.DateFormat('yyyy-MM-dd', const Locale('en', 'US').toString())
        .format(this);
  }

  String toTimeOnly() {
    return intl.DateFormat.Hm(const Locale('en', 'US').toString()).format(this);
  }

  String toTimeWithAmPmFormat() {
    return intl.DateFormat.jm(const Locale('en', 'US').toString()).format(this);
  }
}
