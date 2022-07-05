import 'package:flutter/material.dart';

Decoration customcgradientolor(Color color1, Color color2) {
  return BoxDecoration(
    gradient: RadialGradient(
      colors: [color1, color2],
      center: const Alignment(-0.7, 0.2),
      focal: const Alignment(0.5, -0.3),
      focalRadius: 1.8,
    ),
  );
}
