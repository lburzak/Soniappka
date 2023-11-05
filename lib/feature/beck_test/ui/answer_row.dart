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
      color: selected ? Colors.white24 : Colors.transparent,
      child: ListTile(
        title: Text(text),
        onTap: onSelected,
        contentPadding: const EdgeInsets.symmetric(horizontal: 44),
      ),
    );
  }
}
