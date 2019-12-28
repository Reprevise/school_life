import 'package:flutter/material.dart';

final double _offset = 0.2;
final num _maxLightness = 0.9;
final num _minLightness = 0.15;

extension ColorUtils on Color {
  Color getLighterAccent() {
    var hsl = HSLColor.fromColor(this);
    if (hsl.saturation + _offset > 1) {
      hsl = hsl.withSaturation(1);
    } else {
      hsl = hsl.withSaturation(hsl.saturation + _offset);
    }
    if (hsl.lightness + _offset > _maxLightness) {
      hsl = hsl.withLightness(_maxLightness);
    } else {
      hsl = hsl.withLightness(hsl.lightness + _offset);
    }
    return hsl.toColor();
  }

  Color getDarkerAccent() {
    var hsl = HSLColor.fromColor(this);
    if (hsl.lightness - _offset < _minLightness) {
      hsl = hsl.withLightness(_minLightness);
    } else {
      hsl = hsl.withLightness(hsl.lightness - _offset);
    }
    return hsl.toColor();
  }
}