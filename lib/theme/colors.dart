import 'package:flutter/material.dart';

@immutable
class ExtraColors extends ThemeExtension<ExtraColors> {
  final Color? modalBarrier;

  const ExtraColors({required this.modalBarrier});

  @override
  ExtraColors copyWith({Color? modalBarrier}) {
    return ExtraColors(modalBarrier: modalBarrier ?? this.modalBarrier);
  }

  @override
  ExtraColors lerp(ExtraColors? other, double t) {
    if (other is! ExtraColors) {
      return this;
    }

    return ExtraColors(
      modalBarrier: Color.lerp(modalBarrier, other.modalBarrier, t),
    );
  }
}

extension ExtraColorsGetter on ThemeData {
  ExtraColors get colors => extension<ExtraColors>()!;
}
