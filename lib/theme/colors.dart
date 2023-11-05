import 'package:flutter/material.dart';

@immutable
class ExtraColors extends ThemeExtension<ExtraColors> {
  final Color? modalBarrier;
  final Color? inactive;

  const ExtraColors({
    this.modalBarrier,
    this.inactive,
  });

  @override
  ExtraColors copyWith({Color? modalBarrier, Color? inactive}) {
    return ExtraColors(
      modalBarrier: modalBarrier ?? this.modalBarrier,
      inactive: inactive ?? this.inactive,
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
    );
  }
}

extension ExtraColorsGetter on ThemeData {
  ExtraColors get colors => extension<ExtraColors>()!;
}
