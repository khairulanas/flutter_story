import 'package:flutter/material.dart';
import 'package:flutter_story/src/routes/url_strategy/url_strategy.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/app.dart';

void main() async {
  preferences = await SharedPreferences.getInstance();
  usePathUrlStrategy();
  runApp(const MyApp());
}

late SharedPreferences preferences;
