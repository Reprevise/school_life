import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:school_life/services/device/android_details.dart';
import 'package:school_life/services/prefs_manager.dart';
import 'package:school_life/models/user_settings.dart';

class ThemeService {
  static final ThemeService _themeService = ThemeService._internal();
  static final AndroidDetails _details = AndroidDetails();

  factory ThemeService() => _themeService;

  ThemeService._internal(); // empty constructor

  void saveCurrentBrightnessToDisk(Brightness brightness) {
    prefsManager.saveString(UserSettingsKeys.THEME, _getBrightnessName(brightness));
  }

  static void updateColorsFromBrightness(Brightness brightness) {
    _setStatusBarColor();
    if (brightness == Brightness.dark) {
      return _setDarkNavigationColors();
    }
    return _setLightNavigationColors();
  }

  static void _setLightNavigationColors() {
    if (_details.canChangeNavbarIconColor()) {
      // FlutterStatusbarcolor.setNavigationBarColor(Colors.white);
      // FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
    }
  }

  static void _setDarkNavigationColors() {
    if (_details.canChangeNavbarIconColor()) {
      // FlutterStatusbarcolor.setNavigationBarColor(Colors.grey[900]);
      // FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
    }
  }

  static void _setStatusBarColor() {
    if (_details.canChangeStatusBarColor())
      FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
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
