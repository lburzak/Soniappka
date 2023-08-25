import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class RatingSlider extends StatelessWidget {
  final int? level;
  final int min;
  final int max;
  final void Function(int? level) onChanged;
  final bool compact;

  const RatingSlider(
      {super.key, required this.level, required this.max, required this.onChanged, required this.min})
      : compact = false;

  const RatingSlider.compact(
      {super.key, required this.level, required this.max, required this.onChanged, required this.min})
      : compact = true;

  int get off => min - 1;

  @override
  Widget build(BuildContext context) {
    return SfSliderTheme(
      data: SfSliderThemeData(
          thumbRadius: 8,
          thumbColor: level != null ? null : Colors.grey),
      child: SfSlider(
          value: level ?? off,
          interval: 1.0,
          showTicks: !compact,
          showLabels: !compact,
          showDividers: compact,
          labelFormatterCallback: (value, text) =>
          value != off ? "${value.toInt()}" : "",
          stepSize: 1,
          onChanged: (value) {
            onChanged(value == off ? null : value.toInt());
          },
          min: off,
          max: max),
    );
  }

}
