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

const String lightThemeName = 'Light';
const String darkThemeName = 'Dark';
const String systemThemeName = 'System';

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
    WidgetsBinding.instance.window.onPlatformBrightnessChanged = () {
      if (_mode == ThemeMode.system) {
        final brightness = WidgetsBinding.instance.window.platformBrightness;
        updateColorsFromBrightness(brightness);
      }
    };
  }

  void _loadThemeData() {
    final ThemeMode storedMode = _settingsBox.get(
      BasicSettingsKeys.theme,
      defaultValue: BasicSettingsDefaults.theme,
    );
    _mode = storedMode;
    // TODO: find out how to get system brightness
    final brightness = _getBrightnessFromMode(_mode, null);
    updateColorsFromBrightness(brightness);
    if (mounted) setState(() {});
  }

  Brightness _getBrightnessFromMode(ThemeMode mode, BuildContext context) {
    Brightness brightness;
    switch (mode) {
      case ThemeMode.system:
        brightness = WidgetsBinding.instance.window.platformBrightness;
        print('brightness = $brightness');
        // if (debugCheckHasMediaQuery(context)) {
        //   brightness = MediaQuery.platformBrightnessOf(context);
        // } else {
        //   debugPrint('NO MEDIA QUERY');
        // }
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
    _settingsBox.put(BasicSettingsKeys.theme, newMode);
    final brightness = _getBrightnessFromMode(mode, context);
    updateColorsFromBrightness(brightness);
    setState(() {});
  }

  void updateColorsFromBrightness(Brightness brightness) {
    switch (brightness) {
      case Brightness.light:
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Color(0xFFededed),
          systemNavigationBarIconBrightness: Brightness.dark,
        ));
        break;
      case Brightness.dark:
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Color(0xFF1c1c1c),
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
