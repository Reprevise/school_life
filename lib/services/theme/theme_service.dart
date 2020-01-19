import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:hive/hive.dart';
import 'package:school_life/main.dart';
import 'package:school_life/services/databases/db_helper.dart';
import 'package:school_life/services/device/android_details.dart';
import 'package:school_life/models/user_settings_keys.dart';

class ThemeService {
  ThemeService() {
    _details = getIt.get<AndroidDetails>();
    settings = Hive.box<dynamic>(DatabaseHelper.SETTINGS_BOX);
  }

  AndroidDetails _details;
  Box<dynamic> settings;

  static const Map<Brightness, String> BRIGHTNESS_TO_STRING =
      <Brightness, String>{
    Brightness.light: 'light',
    Brightness.dark: 'dark',
  };

  void saveCurrentBrightnessToDisk(Brightness brightness) {
    settings.put(UserSettingsKeys.THEME, BRIGHTNESS_TO_STRING[brightness]);
  }

  void updateColorsFromBrightness(Brightness brightness) {
    _setStatusBarColor();
    if (brightness == Brightness.dark) {
      return _setDarkNavigationColors();
    }
    return _setLightNavigationColors();
  }

  void _setLightNavigationColors() {
    if (_details.canChangeNavbarIconColor()) {
      // FlutterStatusbarcolor.setNavigationBarColor(Colors.white);
      // FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
    }
  }

  void _setDarkNavigationColors() {
    if (_details.canChangeNavbarIconColor()) {
      // FlutterStatusbarcolor.setNavigationBarColor(Colors.grey[900]);
      // FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
    }
  }

  void _setStatusBarColor() {
    if (_details.canChangeStatusBarColor())
      FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
  }
}
