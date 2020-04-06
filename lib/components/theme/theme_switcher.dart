import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:school_life/models/settings_defaults.dart';
import 'package:school_life/models/settings_keys.dart';
import 'package:school_life/services/databases/db_helper.dart';

typedef ThemedWidgetBuilder = Widget Function(
  BuildContext context,
  ThemeMode mode,
);

final Map<ThemeMode, String> themes = <ThemeMode, String>{
  ThemeMode.light: lightThemeName,
  ThemeMode.dark: darkThemeName,
  ThemeMode.system: systemThemeName,
};

const String lightThemeName = 'light';
const String darkThemeName = 'dark';
const String systemThemeName = 'system';

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({@required this.themedWidgetBuilder});

  final ThemedWidgetBuilder themedWidgetBuilder;

  static _ThemeSwitcherState of(BuildContext context) {
    return context.findAncestorStateOfType<_ThemeSwitcherState>();
  }

  @override
  State<StatefulWidget> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  ThemeMode _mode;
  ThemeMode get mode => _mode;

  Box<dynamic> _settingsBox;

  @override
  void initState() {
    super.initState();
    _settingsBox = Hive.box<dynamic>(Databases.settingsBox);
    _loadThemeData();
  }

  void _loadThemeData() {
    final String modeString = _settingsBox.get(
      BasicSettingsKeys.theme,
      defaultValue: BasicSettingsDefaults.theme,
    );
    _mode = themes.keys.firstWhere((element) => themes[element] == modeString);
    if (_mode != ThemeMode.system) {
      final brightness = _getBrightnessFromMode(_mode, null);
      updateColorsFromBrightness(brightness);
      if (mounted) setState(() {});
    }
  }

  Brightness _getBrightnessFromMode(ThemeMode mode, BuildContext context) {
    Brightness brightness;
    switch (mode) {
      case ThemeMode.system:
        break;
      case ThemeMode.light:
        brightness = Brightness.light;
        break;
      case ThemeMode.dark:
        brightness = Brightness.dark;
        break;
    }
    return brightness;
  }

  void setThemeMode(ThemeMode newMode, BuildContext context) {
    _mode = newMode;
    _settingsBox.put(BasicSettingsKeys.theme, themes[newMode]);
    final brightness = _getBrightnessFromMode(mode, context);
    updateColorsFromBrightness(brightness);
    setState(() {});
  }

  void updateColorsFromBrightness(Brightness brightness) {
    switch (brightness) {
      case Brightness.light:
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
        ));
        break;
      case Brightness.dark:
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.grey.shade900,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Colors.grey.shade900,
          systemNavigationBarIconBrightness: Brightness.light,
        ));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.themedWidgetBuilder(context, _mode);
  }
}
