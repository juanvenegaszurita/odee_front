import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';

import 'package:odee_front/src/cross/cross.dart';
import 'package:odee_front/src/providers/providers.dart';
import 'package:odee_front/src/share_preferences/preferences.dart';
import 'package:odee_front/src/widgets/widgets.dart';

class SettingPage extends StatelessWidget {
  static String title = "setting.title";
  static const route = 'setting';

  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    SettingProvider sp = Provider.of<SettingProvider>(context);
    return ScaffoldGeneric(
      title: "setting.title",
      body: Column(
        children: [
          GridResponsive(
            xl: 1,
            lg: 1,
            md: 1,
            sm: 1,
            xs: 1,
            children: [
              themeListTile(context),
            ],
          ),
          items(
            "setting.language",
            DropdownButton(
              isExpanded: true,
              value: sp.defaultLanguage,
              icon: const Icon(Icons.arrow_downward),
              items: Globals.languageOptions
                  .map<DropdownMenuItem>(
                    (e) => DropdownMenuItem(value: e.key, child: Text(e.value)),
                  )
                  .toList(),
              onChanged: (value) {
                changeLocale(context, value);
                Preferences.defaultLanguage = value;
                sp.defaultLanguage = value;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget items(String text, Widget widget) {
    return GridResponsive(
      xl: 2,
      lg: 2,
      md: 2,
      sm: 1,
      xs: 1,
      children: [
        Text(translate(text)),
        widget,
      ],
    );
  }

  themeListTile(BuildContext context) {
    SettingProvider sp = Provider.of<SettingProvider>(context);
    Map<ThemeSelectedEnum, Widget> myTabs = <ThemeSelectedEnum, Widget>{
      /* ThemeSelectedEnum.system: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.brightness_4),
          const SizedBox(width: 6),
          Text(translate("setting.system")),
        ],
      ), */
      ThemeSelectedEnum.light: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.brightness_low),
          const SizedBox(width: 6),
          Text(translate("setting.light")),
        ],
      ),
      ThemeSelectedEnum.dark: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.brightness_3),
          const SizedBox(width: 6),
          Text(translate("setting.dark")),
        ],
      ),
    };
    return CupertinoSlidingSegmentedControl<ThemeSelectedEnum>(
      groupValue: Preferences.themeSelectedEnum,
      children: myTabs,
      onValueChanged: (i) {
        Preferences.setThemeSelected((i as ThemeSelectedEnum));
        sp.themeMode = Preferences.themeMode;
      },
    );
  }
}
