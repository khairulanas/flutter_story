import 'package:flutter/material.dart';
import 'package:flutter_story/src/app.dart';
import 'package:flutter_story/src/core/common/flavor_type.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_story/src/core/common/shared_p.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  preferences = await SharedPreferences.getInstance();
  usePathUrlStrategy();
  FlavorConfig(
    flavor: FlavorType.paid,
    color: Colors.blue,
    values: const FlavorValues(
      titleApp: "Paid Version App",
    ),
  );

  runApp(const MyApp());
}
