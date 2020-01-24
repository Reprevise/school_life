import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:school_life/main.dart';
import 'package:school_life/models/user_settings_keys.dart';
import 'package:school_life/services/databases/db_helper.dart';
import 'package:school_life/services/theme/theme_service.dart';
import 'package:school_life/theme/style.dart';

typedef ThemedWidgetBuilder = Widget Function(
    BuildContext context, ThemeData data);

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({
    Key key,
    @required this.themedWidgetBuilder,
  }) : super(key: key);

  final ThemedWidgetBuilder themedWidgetBuilder;

  static _ThemeSwitcherState of(BuildContext context) {
    return context.findAncestorStateOfType<_ThemeSwitcherState>();
  }

  @override
  State<StatefulWidget> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  ThemeData _themeData;
  Brightness _brightness;
  Brightness get brightness => _brightness;

  Box<dynamic> _settingsBox;

  final Map<Brightness, ThemeData> brightnessThemes = <Brightness, ThemeData>{
    Brightness.light: lightTheme,
    Brightness.dark: darkTheme,
  };

  @override
  void initState() {
    super.initState();
    _settingsBox = Hive.box(DatabaseHelper.SETTINGS_BOX);
    _loadThemeData();
  }

  void _loadThemeData() {
    _brightness = _settingsBox.get(UserSettingsKeys.THEME,
        defaultValue: Brightness.light) as Brightness;
    _themeData = brightnessThemes[_brightness];
    if (mounted) {
      setState(() {});
    }
  }

  void setBrightness(Brightness newBrightness) {
    getIt<ThemeService>().updateColorsFromBrightness(newBrightness);
    setState(() {
      _brightness = newBrightness;
      _themeData = brightnessThemes[newBrightness];
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.themedWidgetBuilder(context, _themeData);
  }
}
