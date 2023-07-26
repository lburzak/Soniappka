import 'package:collection/collection.dart';
import 'package:easy_beck/beck_test/ui/page_indicator.dart';
import 'package:easy_beck/beck_test/ui/question_page.dart';
import 'package:flutter/material.dart';

class QuestionnaireView extends StatefulWidget {
  final Map<int, List<String>> options;
  final Map<int, int?> answers;
  final void Function(int questionIndex, int answerIndex) onAnswerSelected;

  const QuestionnaireView(
      {super.key,
        required this.options,
        required this.onAnswerSelected,
        required this.answers});

  @override
  State<QuestionnaireView> createState() => _QuestionnaireViewState();
}

class _QuestionnaireViewState extends State<QuestionnaireView> {
  final currentPageValueNotifier = ValueNotifier(0);
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: PageView(
            onPageChanged: (newPage) {
              currentPageValueNotifier.value = newPage;
            },

            /// [PageView.scrollDirection] defaults to [Axis.horizontal].
            /// Use [Axis.vertical] to scroll vertically.
            controller: controller,
            children: widget.options.entries
                .map((entry) => QuestionPage(
              options: entry.value,
              onAnswerSelected: (answerIndex) {
                widget.onAnswerSelected(entry.key, answerIndex);
              },
              selectedAnswerIndex: widget.answers[entry.key],
            ))
                .toList(),
          ),
        ),
        ValueListenableBuilder(
            valueListenable: currentPageValueNotifier,
            builder: (context, value, child) => PageIndicator(
              currentPageIndex: value,
              filledIndices: widget.answers.entries
                  .map((element) =>
              element.value != null ? element.key : null)
                  .whereNotNull()
                  .toList(),
              pagesCount: widget.options.length,
            ))
      ],
    );
  }
}
