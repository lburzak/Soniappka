import 'dart:math';

import 'package:flutter/painting.dart';


Color generateRandomPastelColor() {
  // Random hue (0 to 360 degrees)
  int hue = Random().nextInt(361);

  // Random low saturation (30% to 50%)
  double saturation = Random().nextDouble() * (50 - 30) + 30;

  // Random high lightness (70% to 90%)
  double lightness = Random().nextDouble() * (90 - 70) + 70;

  // Convert HSL to RGB
  double h = hue / 360.0;
  double s = saturation / 100.0;
  double l = lightness / 100.0;

  // Algorithm to convert HSL to RGB
  double hueToRgb(double p, double q, double t) {
    if (t < 0) t += 1;
    if (t > 1) t -= 1;
    if (t < 1 / 6) return p + (q - p) * 6 * t;
    if (t < 1 / 2) return q;
    if (t < 2 / 3) return p + (q - p) * (2 / 3 - t) * 6;
    return p;
  }

  double r, g, b;
  if (s == 0) {
    r = g = b = l;
  } else {
    double q = l * (1 + s) * (l < 0.5 ? 1 : 2) - s * l;
    double p = 2 * l - q;
    r = hueToRgb(p, q, h + 1 / 3);
    g = hueToRgb(p, q, h);
    b = hueToRgb(p, q, h - 1 / 3);
  }

  // Scale RGB values to 0-255 range and round to integers
  int red = (r * 255).round();
  int green = (g * 255).round();
  int blue = (b * 255).round();

  return Color.fromARGB(0xff, red, green, blue);
}
