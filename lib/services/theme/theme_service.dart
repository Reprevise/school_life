import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:injectable/injectable.dart';
import 'package:school_life/services/device/android_details.dart';

@singleton
@injectable
class ThemeService {
  ThemeService(AndroidDetails details) {
    _details = details;
  }

  AndroidDetails _details;

  static const Map<Brightness, String> brightnessLevels =
      <Brightness, String>{
    Brightness.light: 'light',
    Brightness.dark: 'dark',
  };

  void updateColorsFromBrightness(Brightness brightness) {
    if (_details.canChangeStatusBarColor()) {
      FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
      brightness == Brightness.light
          ? FlutterStatusbarcolor.setStatusBarWhiteForeground(false)
          : FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    }
    if (brightness == Brightness.dark) {
      return _setDarkNavigationColors();
    }
    return _setLightNavigationColors();
  }

  void _setLightNavigationColors() {
    if (_details.canChangeNavbarIconColor()) {
      FlutterStatusbarcolor.setNavigationBarColor(Colors.white);
      FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
    }
  }

  void _setDarkNavigationColors() {
    if (_details.canChangeNavbarIconColor()) {
      FlutterStatusbarcolor.setNavigationBarColor(Colors.grey[900]);
      FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
    }
  }
}
