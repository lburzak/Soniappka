import 'package:easy_beck/beck_test/ui/page_icon.dart';
import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int currentPageIndex;
  final List<int> filledIndices;
  final int pagesCount;

  const PageIndicator(
      {super.key,
        required this.currentPageIndex,
        required this.filledIndices,
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
                filled: filledIndices.contains(index),
              )),
        ),
        const SizedBox(height: 12),
        Text(
          "${currentPageIndex + 1} / $pagesCount",
          style: const TextStyle(fontSize: 20),
        )
      ],
    );
  }
}
