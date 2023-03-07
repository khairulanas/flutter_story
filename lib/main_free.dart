import 'package:flutter/material.dart';
import 'package:flutter_story/src/app.dart';
import 'package:flutter_story/src/core/common/flavor_type.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/core/common/shared_p.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  preferences = await SharedPreferences.getInstance();
  usePathUrlStrategy();
  FlavorConfig(
    flavor: FlavorType.free,
    color: Colors.orange,
    values: const FlavorValues(
      titleApp: "Free Version App",
    ),
  );

  runApp(const MyApp());
}
