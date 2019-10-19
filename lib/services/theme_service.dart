import 'package:flutter/material.dart';
import 'package:school_life/screens/settings/settings.dart';
import 'package:school_life/services/android_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  final AndroidDetails details = AndroidDetails();

  Future<bool> _checkForNightMode() async {
    Map<String, dynamic> critDetails = await details.getCritDeviceData();
    String brand = critDetails['brand'];
    int version = critDetails['version.sdkInt'];
    if ((brand == "samsung" && version >= 28) ||
        (brand == "google" && version >= 29)) {
      return Future.value(true);
    }
    return Future.value(false);
  }

  Future<bool> _checkDeviceEqualOrAboveVersionSeven() async {
    Map<String, dynamic> critDetails = await details.getCritDeviceData();
    int version = critDetails['version.sdkInt'];
    if (version >= 24) return Future.value(true);
    return Future.value(false);
  }

  Future<bool> checkDeviceCompatableToChangeTheme() async {
    bool hasNightMode = await _checkForNightMode();
    bool isAboveOrEqualAndroidSeven =
        await _checkDeviceEqualOrAboveVersionSeven();
    // has to be above v. 7 but not have night/dark mode
    if (!hasNightMode && isAboveOrEqualAndroidSeven) {
      return Future.value(true);
    }
    return Future.value(false);
  }

  Future<ThemeKeys> getCurrentTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final storedTheme = prefs.getString("theme");
    final ThemeKeys _theme =
        storedTheme == "LIGHT" ? ThemeKeys.LIGHT : ThemeKeys.DARK;
    return _theme;
  }

  Future<Brightness> getBrightness() async {
    final ThemeKeys storedThemeKey = await getCurrentTheme();
    final bool canChangeTheme = await checkDeviceCompatableToChangeTheme();
    if (canChangeTheme) return Future.value(null);
    if (storedThemeKey == ThemeKeys.LIGHT)
      return Future.value(Brightness.light);
    else
      return Future.value(Brightness.dark);
  }
}
