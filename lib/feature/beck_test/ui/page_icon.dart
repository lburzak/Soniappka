import 'package:easy_beck/common/ui/theme/borders.dart';
import 'package:easy_beck/common/ui/theme/theme_getter.dart';
import 'package:flutter/material.dart';

class PageIcon extends StatelessWidget {
  final bool selected;
  final bool filled;

  const PageIcon({super.key, required this.selected, required this.filled});

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: selected ? 9 : 7,
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: filled ? context.theme.colorScheme.primary : null,
            border: selected
                ? context.theme.borders.regular
                : context.theme.borders.thin),
      ),
    );
  }
}
