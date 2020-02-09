import 'dart:math';
import 'dart:ui';

class RandomColor {
  static final Random _random = Random();

  static Color next() {
    return Color(0xFF000000 + _random.nextInt(0x00FFFFFF));
  }
}