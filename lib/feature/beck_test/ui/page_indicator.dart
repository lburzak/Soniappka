import 'package:easy_beck/feature/beck_test/ui/page_icon.dart';
import 'package:easy_beck/theme/theme_getter.dart';
import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int currentPageIndex;
  final bool Function(int index) isFilled;
  final int pagesCount;

  const PageIndicator(
      {super.key,
        required this.currentPageIndex,
        required this.isFilled,
        required this.pagesCount});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 7,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: List.generate(
              pagesCount,
                  (index) => PageIcon(
                selected: index == currentPageIndex,
                filled: isFilled(index),
              )),
        ),
        const SizedBox(height: 12),
        Text(
          "${currentPageIndex + 1} / $pagesCount",
          style: context.theme.textTheme.titleMedium,
        )
      ],
    );
  }
}
