import 'package:easy_beck/feature/beck_test/ui/page_indicator.dart';
import 'package:easy_beck/feature/beck_test/ui/question_page.dart';
import 'package:easy_beck/common/ui/pastel_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

abstract interface class QuestionnaireState {
  ValueListenable<int?> getSelectedAnswerForQuestionIndex(int index);

  int? getNextPage(int currentPage);

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
    final colors = useMemoized(() =>
        List.generate(options.length, (index) => generateRandomPastelColor()));

    return Stack(
      alignment: Alignment.center,
      children: [
        PageView(
          onPageChanged: (newPage) {
            currentPageNotifier.value = newPage;
          },
          controller: pageController,
          children: options.entries
              .map((entry) => Container(
                    color: colors.elementAtOrNull(entry.key),
                    child: QuestionPage(
                        options: entry.value,
                        onAnswerSelected: (answerIndex) {
                          onAnswerSelected(entry.key, answerIndex);
                          final nextPage = state
                              .getNextPage(pageController.page?.ceil() ?? 0);
                          if (nextPage != null) {
                            pageController.animateToPage(nextPage,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.fastOutSlowIn);
                          }
                        },
                        selectedAnswerIndex:
                            state.getSelectedAnswerForQuestionIndex(entry.key)),
                  ))
              .toList(),
        ),
        Positioned(
          bottom: 16,
          child: ListenableBuilder(
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
              }),
        )
      ],
    );
  }
}
