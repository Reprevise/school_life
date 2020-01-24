import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:school_life/main.dart';
import 'package:school_life/services/device/android_details.dart';

class ThemeService {
  ThemeService() {
    _details = getIt.get<AndroidDetails>();
  }

  AndroidDetails _details;

  static const Map<Brightness, String> BRIGHTNESS_TO_STRING =
      <Brightness, String>{
    Brightness.light: 'light',
    Brightness.dark: 'dark',
  };

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
