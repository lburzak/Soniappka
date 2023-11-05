import 'package:easy_beck/feature/beck_test/ui/questionnaire_view.dart';
import 'package:easy_beck/feature/beck_test/model/state.dart';
import 'package:easy_beck/theme/theme_getter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DefaultQuestionnaireState implements QuestionnaireState {
  final Map<int, ValueNotifier<int?>> _listenables = {};
  final ValueNotifier<List<int>> _answeredQuestionsIndices = ValueNotifier([]);

  void update(Map<int, int?> answers) {
    for (var MapEntry(key: index, value: answer) in answers.entries) {
      if (_listenables.containsKey(index)) {
        _listenables[index]!.value = answer;
      } else {
        _listenables[index] = ValueNotifier(answer);
      }

      _answeredQuestionsIndices.value = answers.entries
          .where((element) => element.value != null)
          .map((e) => e.key)
          .toList();
    }
  }

  @override
  ValueListenable<int?> getSelectedAnswerForQuestionIndex(int index) {
    return _listenables.putIfAbsent(index, () => ValueNotifier(null));
  }

  @override
  ValueListenable<List<int>> get answeredQuestionsIndices =>
      _answeredQuestionsIndices;

  @override
  int? getNextPage(int currentPage) {
    final unfilled = _listenables.entries.where(
        (element) => !_answeredQuestionsIndices.value.contains(element.key));

    final firstAfterCurrent =
        unfilled.where((value) => value.key > currentPage).firstOrNull;
    if (firstAfterCurrent != null) {
      return firstAfterCurrent.key;
    }

    return unfilled.where((value) => value.key != currentPage).firstOrNull?.key;
  }
}

QuestionnaireState useQuestionnaireState(Stream<Map<int, int?>> answers) {
  final state = DefaultQuestionnaireState();

  useOnStreamChange(answers, onData: (data) {
    state.update(data);
  });

  return state;
}

class BeckTestView extends HookWidget {
  final Stream<BeckTestState> state;
  final void Function(int questionIndex, int answerIndex) onAnswerSelected;
  final void Function() onSubmit;

  const BeckTestView(
      {super.key,
      required this.state,
      required this.onAnswerSelected,
      required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final questionnaireState =
        useQuestionnaireState(state.map((event) => event.answers));

    return Scaffold(
      backgroundColor: context.theme.colorScheme.background,
      floatingActionButton: StreamBuilder(
        stream: state.map((event) => event.canSubmit),
        builder: (context, snapshot) => Visibility(
          visible: snapshot.data ?? false,
          child: FloatingActionButton(
            onPressed: onSubmit,
            child: const Icon(Icons.done),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: state.map((event) => event.options).distinct(),
        builder: (context, snapshot) => QuestionnaireView(
          state: questionnaireState,
          options: snapshot.data ?? {},
          onAnswerSelected: onAnswerSelected,
        ),
      ),
    );
  }
}
