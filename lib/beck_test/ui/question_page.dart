import 'package:collection/collection.dart';
import 'package:easy_beck/beck_test/ui/answer_row.dart';
import 'package:flutter/material.dart';

class QuestionPage extends StatelessWidget {
  final List<String> options;
  final int? selectedAnswerIndex;
  final void Function(int index) onAnswerSelected;

  const QuestionPage(
      {super.key,
        required this.options,
        this.selectedAnswerIndex,
        required this.onAnswerSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: options
          .mapIndexed((index, answer) => AnswerRow(
        text: answer,
        selected: index == selectedAnswerIndex,
        onSelected: () {
          onAnswerSelected(index);
        },
      ))
          .toList(),
    );
  }
}
