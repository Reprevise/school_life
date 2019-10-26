import 'package:dynamic_theme/dynamic_theme.dart';
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
      return true;
    }
    return false;
  }

  Future<bool> _checkDeviceEqualOrAboveVersionSeven() async {
    Map<String, dynamic> critDetails = await details.getCritDeviceData();
    int version = critDetails['version.sdkInt'];
    if (version >= 24) return true;
    return false;
  }

  Future<bool> checkDeviceCompatableToChangeTheme() async {
    bool hasNightMode = await _checkForNightMode();
    bool isAboveOrEqualAndroidSeven =
        await _checkDeviceEqualOrAboveVersionSeven();
    // has to be above v. 7 but not have night/dark mode
    if (!hasNightMode && isAboveOrEqualAndroidSeven) {
      return true;
    }
    return false;
  }

  void changeBrightness(Brightness brightness, BuildContext context) async {
    Brightness currentThemeBrightness = DynamicTheme.of(context).brightness;
    if (currentThemeBrightness == brightness) return;
    bool canChangeSystemBrightness = await checkDeviceCompatableToChangeTheme();
    Brightness platformBrightness = MediaQuery.of(context).platformBrightness;
    if (canChangeSystemBrightness) {
      DynamicTheme.of(context).setBrightness(platformBrightness);
      return;
    }
    // if user can't change sys brightness, change to desired brightness
    DynamicTheme.of(context).setBrightness(brightness);
  }

  Future<ThemeKeys> getCurrentTheme() async {
    final bool canChangeTheme = await checkDeviceCompatableToChangeTheme();
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
