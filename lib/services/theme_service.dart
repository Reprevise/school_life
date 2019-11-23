import 'package:flutter/material.dart';
import 'package:school_life/util/models/user_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  static final ThemeService _themeService = ThemeService._internal();

  factory ThemeService() => _themeService;

  ThemeService._internal();

  Future<void> saveCurrentBrightnessToDisk(Brightness brightness) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(UserSettings.THEME, getBrightnessName(brightness));
  }

  Future<Brightness> getSavedBrightness() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _savedBrightnessString = prefs.getString(UserSettings.THEME);
    if (_savedBrightnessString == null) {
      await saveCurrentBrightnessToDisk(Brightness.light);
      return Future.value(Brightness.light);
    }
    final Brightness _savedBrightness = getBrightnessFromString(_savedBrightnessString);
    return Future.value(_savedBrightness);
  }

  static Brightness getBrightnessFromString(String themeModeName) {
    switch (themeModeName.toLowerCase()) {
      case "light":
        return Brightness.light;
      case "dark":
        return Brightness.dark;
      default:
        return Brightness.light;
    }
  }

  static String getBrightnessName(Brightness brightness) {
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
