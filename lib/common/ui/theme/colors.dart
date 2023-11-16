import 'package:flutter/material.dart';

@immutable
class ExtraColors extends ThemeExtension<ExtraColors> {
  final Color? modalBarrier;
  final Color? inactive;
  final Color? backgroundVariant;
  final Color? backgroundDark;

  const ExtraColors({
    this.modalBarrier,
    this.inactive,
    this.backgroundVariant,
    this.backgroundDark,
  });

  @override
  ExtraColors copyWith(
      {Color? modalBarrier,
      Color? inactive,
      Color? backgroundVariant,
      Color? backgroundDark}) {
    return ExtraColors(
      modalBarrier: modalBarrier ?? this.modalBarrier,
      inactive: inactive ?? this.inactive,
      backgroundVariant: backgroundVariant ?? this.backgroundVariant,
      backgroundDark: backgroundDark ?? this.backgroundDark,
    );
  }

  @override
  ExtraColors lerp(ExtraColors? other, double t) {
    if (other is! ExtraColors) {
      return this;
    }

    return ExtraColors(
      modalBarrier: Color.lerp(modalBarrier, other.modalBarrier, t),
      inactive: Color.lerp(inactive, other.inactive, t),
      backgroundVariant:
          Color.lerp(backgroundVariant, other.backgroundVariant, t),
      backgroundDark: Color.lerp(backgroundDark, other.backgroundDark, t),
    );
  }
}

extension ExtraColorsGetter on ThemeData {
  ExtraColors get colors => extension<ExtraColors>()!;
}
