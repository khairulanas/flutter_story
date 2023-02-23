import 'package:flutter/material.dart';
import 'package:flutter_story/src/core/common/localization.dart';
import 'package:flutter_story/src/provider/localization_provider.dart';
import 'package:flutter_story/src/provider/story_list_provider.dart';
import 'package:provider/provider.dart';

class DropdownLanguage extends StatelessWidget {
  const DropdownLanguage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalizationProvider>(builder: (_, prov, __) {
      return DropdownButton(
        value: prov.locale,
        items: AppLocalizations.supportedLocales.map((Locale locale) {
          final flag = Localization.getFlag(locale.languageCode);
          return DropdownMenuItem(
            value: locale,
            child: Center(
              child: Text(
                flag,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            onTap: () {
              final provider =
                  Provider.of<LocalizationProvider>(context, listen: false);
              provider.setLocale(locale);
              context.read<StoryListProvider>().pageItems = 1;
            },
          );
        }).toList(),
        onChanged: (_) {},
      );
    });
  }
}
