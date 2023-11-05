import 'package:easy_beck/common/ui/theme/backgrounds.dart';
import 'package:easy_beck/common/ui/theme/theme_getter.dart';
import 'package:flutter/material.dart';

class AnswerRow extends StatelessWidget {
  final String text;
  final bool selected;
  final void Function() onSelected;

  const AnswerRow(
      {super.key,
      required this.text,
      required this.selected,
      required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: selected ? context.theme.backgrounds.selected : null,
      child: ListTile(
        title: Text(text),
        onTap: onSelected,
        contentPadding: const EdgeInsets.symmetric(horizontal: 44),
      ),
    );
  }
}
