import 'package:flutter_web_plugins/url_strategy.dart';

/// create this blank function to web platform
void usePathUrlStrategy() {
  setUrlStrategy(PathUrlStrategy());
}
