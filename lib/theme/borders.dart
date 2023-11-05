import 'package:flutter/material.dart';

@immutable
class Borders extends ThemeExtension<Borders> {
  final Border thin;
  final Border regular;
  final Border bold;

  const Borders({required this.thin, required this.regular, required this.bold});

  @override
  Borders copyWith({Border? thin, Border? regular, Border? bold}) {
    return Borders(
        thin: thin ?? this.thin,
        regular: regular ?? this.regular,
        bold: bold ?? this.bold);
  }

  @override
  Borders lerp(Borders? other, double t) {
    return this;
  }
}

extension BordersGetter on ThemeData {
  Borders get borders => extension<Borders>()!;
}
