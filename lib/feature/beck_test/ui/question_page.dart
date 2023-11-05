import 'package:collection/collection.dart';
import 'package:easy_beck/feature/beck_test/ui/answer_row.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class QuestionPage extends HookWidget {
  final List<String> options;
  final ValueListenable<int?> selectedAnswerIndex;
  final void Function(int index) onAnswerSelected;

  const QuestionPage(
      {super.key,
        required this.options,
        required this.selectedAnswerIndex,
        required this.onAnswerSelected});

  @override
  Widget build(BuildContext context) {
    final selectedAnswer = useValueListenable(selectedAnswerIndex);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: options
          .mapIndexed((index, answer) => AnswerRow(
        text: answer,
        selected: index == selectedAnswer,
        onSelected: () {
          onAnswerSelected(index);
        },
      ))
          .toList(),
    );
  }
}
