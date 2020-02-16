import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:school_life/main.dart';
import 'package:school_life/models/settings_defaults.dart';
import 'package:school_life/models/settings_keys.dart';
import 'package:school_life/services/databases/db_helper.dart';
import 'package:school_life/services/device/android_details.dart';
import 'package:school_life/components/theme/style.dart';

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
  AndroidDetails _details;

  final Map<Brightness, ThemeData> brightnessThemes = <Brightness, ThemeData>{
    Brightness.light: lightTheme,
    Brightness.dark: darkTheme,
  };

  @override
  void initState() {
    super.initState();
    _settingsBox = Hive.box<dynamic>(Databases.settingsBox);
    _details = sl<AndroidDetails>();
    _loadThemeData();
  }

  void _loadThemeData() {
    _brightness = _settingsBox.get(BasicSettingsKeys.theme,
        defaultValue: BasicSettingsDefaults.theme) as Brightness;
    updateColorsFromBrightness(_brightness);
    _themeData = brightnessThemes[_brightness];
    if (mounted) {
      setState(() {});
    }
  }

  void setBrightness(Brightness newBrightness) {
    updateColorsFromBrightness(newBrightness);
    _settingsBox.put(BasicSettingsKeys.theme, newBrightness);
    setState(() {
      _brightness = newBrightness;
      _themeData = brightnessThemes[newBrightness];
    });
  }

  void updateColorsFromBrightness(Brightness brightness) {
    var style = SystemUiOverlayStyle();
    if (_details.canChangeStatusBarColor()) {
      style = style.copyWith(
        statusBarColor: Colors.transparent,
        statusBarBrightness: brightness,
      );
      if (brightness == Brightness.light) {
        style = style.copyWith(
          statusBarIconBrightness: Brightness.dark,
        );
      } else {
        style = style.copyWith(
          statusBarIconBrightness: Brightness.light,
        );
      }
    }
    if (_details.canChangeNavbarIconColor()) {
      if (brightness == Brightness.dark) {
        style.copyWith(
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
        );
        return;
      }
      style.copyWith(
        systemNavigationBarColor: Colors.grey.shade900,
        systemNavigationBarIconBrightness: Brightness.light,
      );
    }
    SystemChrome.setSystemUIOverlayStyle(style);
  }

  @override
  Widget build(BuildContext context) {
    return widget.themedWidgetBuilder(context, _themeData);
  }
}
