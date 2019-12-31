import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:hive/hive.dart';
import 'package:school_life/main.dart';
import 'package:school_life/services/databases/db_helper.dart';
import 'package:school_life/services/device/android_details.dart';
import 'package:school_life/models/user_settings.dart';

class ThemeService {
  static AndroidDetails _details;
  Box settings;
  static const Map<Brightness, String> BRIGHTNESS_TO_STRING = {
    Brightness.light: "light",
    Brightness.dark: "dark",
  };

  ThemeService() {
    _details = getIt<AndroidDetails>();
    settings = Hive.box(DatabaseHelper.SETTINGS_BOX);
  } // empty constructor

  void saveCurrentBrightnessToDisk(Brightness brightness) {
    settings.put(UserSettingsKeys.THEME, BRIGHTNESS_TO_STRING[brightness]);
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
}
