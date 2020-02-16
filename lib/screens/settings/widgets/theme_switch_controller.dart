import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_controls.dart';

class ThemeSwitchController extends FlareControls {

  bool _isDark = false;

  static const String switchToNight = 'switch_night';
  static const String switchToDay = 'switch_day';
  static const String dayIdle = 'day_idle';
  static const String nightIdle = 'night_idle';

  void setDarkness(newDarkness) {
    _isDark = newDarkness;
    if (_isDark == true) {
      play(switchToNight);
    } else {
      play(switchToDay);
    }
  }

  @override
  void onCompleted(String name) {
    if (name == switchToNight) {
      play(nightIdle);
    } else if (name == switchToDay) {
      play(dayIdle);
    }
  }

  @override
  void initialize(FlutterActorArtboard artboard) {
    super.initialize(artboard);
    play(_isDark == true ? nightIdle : dayIdle);
  }
}