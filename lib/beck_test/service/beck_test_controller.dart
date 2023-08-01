import 'dart:async';

import 'package:collection/collection.dart';
import 'package:easy_beck/beck_test/model/state.dart';
import 'package:easy_beck/beck_test/repository/question_repository.dart';
import 'package:easy_beck/beck_test/service/beck_test_router.dart';
import 'package:easy_beck/beck_test/usecase/submit_beck_test.dart';
import 'package:easy_beck/common/map_extensions.dart';
import 'package:rxdart/rxdart.dart';

const _initialState = BeckTestState(
    questionsCount: 0, answers: {}, options: {}, canSubmit: false);

class BeckTestController {
  final QuestionRepository _questionRepository;
  final SubmitBeckTest _submitBeckTest;
  final BeckTestRouter _beckTestRouter;

  final _state = BehaviorSubject<BeckTestState>.seeded(_initialState);
  late final Stream<BeckTestState> state = _state.doOnListen(_load);

  BeckTestController(
      this._questionRepository, this._submitBeckTest, this._beckTestRouter);

  void selectAnswer(int questionIndex, int answerIndex) {
    final BehaviorSubject(value: currentState) = _state;
    _state.add(currentState.copyWith(
        answers: currentState.answers
            .withValueAt(key: questionIndex, value: answerIndex),
        canSubmit: currentState.answers.entries
            .whereNot((element) => element.key == questionIndex)
            .every((element) => element.value != null)));
  }

  void submit() async {
    final BehaviorSubject(value: currentState) = _state;
    final points = currentState.answers.values
        .whereNotNull()
        .fold(0, (previousValue, answerIndex) => previousValue + answerIndex);

    final result = await _submitBeckTest(points);

    _beckTestRouter.goToTestResult(result.id);
  }

  Future<void> _load() async {
    final questions = await _questionRepository.getQuestions();

    final answers = Map.fromEntries(
        List.generate(questions.length, (index) => MapEntry(index, null)));

    final options = questions.mapIndexed(
        (index, question) => MapEntry(index, question.answersTexts.toList()));

    _state.add(BeckTestState(
        questionsCount: questions.length,
        answers: answers,
        options: options.collectToMap()));
  }
}
