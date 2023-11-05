import 'package:flutter/material.dart';

@immutable
class Borders extends ThemeExtension<Borders> {
  final Border? thin;
  final Border? regular;

  const Borders({required this.thin, required this.regular});

  @override
  Borders copyWith({Border? thin, Border? regular}) {
    return Borders(thin: thin ?? this.thin, regular: regular ?? this.regular);
  }

  @override
  Borders lerp(Borders? other, double t) {
    return this;
  }
}

extension BordersGetter on ThemeData {
  Borders get borders => extension<Borders>()!;
}
