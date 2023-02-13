export 'package:flutter_gen/gen_l10n/app_localizations.dart';
export 'package:flutter_localizations/flutter_localizations.dart';

class Localization {
  static String getFlag(String code) {
    switch (code) {
      case 'en':
        return "English - 🇺🇸";
      case 'id':
      default:
        return "Indonesia - 🇮🇩";
    }
  }
}
