import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String dateFormat(BuildContext context, DateTime date) {
  String locale = Localizations.localeOf(context).languageCode;
  String dayOfWeek = DateFormat.yMd(locale).add_jm().format(date);
  return dayOfWeek;
}
