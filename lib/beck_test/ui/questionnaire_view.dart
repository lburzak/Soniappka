import 'package:easy_beck/beck_test/ui/page_indicator.dart';
import 'package:easy_beck/beck_test/ui/question_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

abstract interface class QuestionnaireState {
  ValueListenable<int?> getSelectedAnswerForQuestionIndex(int index);

  ValueListenable<List<int>> get answeredQuestionsIndices;
}

class QuestionnaireView extends HookWidget {
  final Map<int, List<String>> options;
  final QuestionnaireState state;
  final void Function(int questionIndex, int answerIndex) onAnswerSelected;

  const QuestionnaireView(
      {super.key,
      required this.options,
      required this.onAnswerSelected,
      required this.state});

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    final currentPageNotifier = useState(0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: PageView(
            onPageChanged: (newPage) {
              currentPageNotifier.value = newPage;
            },

            /// [PageView.scrollDirection] defaults to [Axis.horizontal].
            /// Use [Axis.vertical] to scroll vertically.
            controller: pageController,
            children: options.entries
                .map((entry) => QuestionPage(
                    options: entry.value,
                    onAnswerSelected: (answerIndex) {
                      onAnswerSelected(entry.key, answerIndex);
                      if (pageController.page?.floor() == options.length) {
                        pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.fastOutSlowIn);
                      }
                    },
                    selectedAnswerIndex:
                        state.getSelectedAnswerForQuestionIndex(entry.key)))
                .toList(),
          ),
        ),
        ListenableBuilder(
            listenable: Listenable.merge(
                [state.answeredQuestionsIndices, currentPageNotifier]),
            builder: (context, _) {
              return PageIndicator(
                currentPageIndex: currentPageNotifier.value,
                isFilled: (index) =>
                    state.getSelectedAnswerForQuestionIndex(index).value !=
                    null,
                pagesCount: options.length,
              );
            })
      ],
    );
  }
}
