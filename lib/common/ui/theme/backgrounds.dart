import 'package:flutter/material.dart';

@immutable
class Backgrounds extends ThemeExtension<Backgrounds> {
  final Color? selected;

  const Backgrounds({required this.selected});

  @override
  Backgrounds copyWith({Color? selected}) {
    return Backgrounds(selected: selected ?? this.selected);
  }

  @override
  Backgrounds lerp(Backgrounds? other, double t) {
    if (other is! Backgrounds) {
      return this;
    }

    return Backgrounds(
      selected: Color.lerp(selected, other.selected, t),
    );
  }
}

extension BackgroundsGetter on ThemeData {
  Backgrounds get backgrounds => extension<Backgrounds>()!;
}
