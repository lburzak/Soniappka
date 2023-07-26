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
            color: filled ? Color(0xffA3CC85) : Colors.transparent,
            border: Border.fromBorderSide(
                BorderSide(color: Colors.black, width: selected ? 1 : 0.5))),
      ),
    );
  }
}
