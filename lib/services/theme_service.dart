import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:school_life/screens/settings/settings.dart';
import 'package:school_life/services/android_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  final AndroidDetails details = AndroidDetails();

  Future<bool> hasNightOrDarkMode() async {
    Map<String, dynamic> critDetails = await details.getCritDeviceData();
    String brand = critDetails['brand'];
    int version = critDetails['version.sdkInt'];
    if ((brand == "samsung" && version >= 28) ||
        (brand == "google" && version >= 29)) {
      return true;
    }
    return false;
  }

  Future<bool> hasAndroidSevenPlusAndNotNightMode() async {
    final bool _hasNightOrDarkMode = await hasNightOrDarkMode();
    Map<String, dynamic> critDetails = await details.getCritDeviceData();
    int version = critDetails['version.sdkInt'];
    // if has or above android 7 but doesn't have night mode
    if (version >= 24 && !_hasNightOrDarkMode) return true;
    return false;
  }

  void changeToSysBrightness(BuildContext context) async {
    bool canChangeSystemBrightness = await hasNightOrDarkMode();
    Brightness platformBrightness = MediaQuery.of(context).platformBrightness;
    if (canChangeSystemBrightness) {
      DynamicTheme.of(context).setBrightness(platformBrightness);
      return;
    }
  }

  Future<ThemeKeys> getCurrentTheme() async {
    final bool canChangeTheme = await hasNightOrDarkMode();
    if (canChangeTheme) return null;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final storedTheme = prefs.getString("theme");
    final ThemeKeys _theme =
        storedTheme == "DARK" ? ThemeKeys.DARK : ThemeKeys.LIGHT;
    return _theme;
  }

  Future<void> saveTheme(ThemeKeys themeToSave) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("theme", themeToSave == ThemeKeys.LIGHT ? "LIGHT" : "DARK");
  }
}
