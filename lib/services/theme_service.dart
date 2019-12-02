import 'package:flutter/material.dart';
import 'package:school_life/theme/themes.dart';
import 'package:school_life/util/models/user_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  static final ThemeService _themeService = ThemeService._internal();
  Brightness _brightness;

  factory ThemeService() => _themeService;

  ThemeService._internal() {
    getSavedBrightness();
  }

  Future<void> saveCurrentBrightnessToDisk(Brightness brightness) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(UserSettings.THEME, _getBrightnessName(brightness));
    _brightness = brightness;
  }

  Future<void> getSavedBrightness() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String _savedBrightnessString = prefs.getString(UserSettings.THEME);
    if (_savedBrightnessString == null) {
      await saveCurrentBrightnessToDisk(Brightness.light);
    } else {
      _brightness = _getBrightnessFromString(_savedBrightnessString);
    }
  }

  void updateColors() async {
    _brightness ?? await getSavedBrightness();
    Themes.updateColorsFromBrightness(_brightness);
  }

  static Brightness _getBrightnessFromString(String themeModeName) {
    switch (themeModeName.toLowerCase()) {
      case "light":
        return Brightness.light;
      case "dark":
        return Brightness.dark;
      default:
        return Brightness.light;
    }
  }

  static String _getBrightnessName(Brightness brightness) {
    switch (brightness) {
      case Brightness.light:
        return "light";
      case Brightness.dark:
        return "dark";
      default:
        return "light";
    }
  }
}
