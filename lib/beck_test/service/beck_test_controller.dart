import 'dart:async';

import 'package:collection/collection.dart';
import 'package:easy_beck/beck_test/model/beck_test_result.dart';
import 'package:easy_beck/beck_test/model/state.dart';
import 'package:easy_beck/beck_test/repository/beck_test_result_repository.dart';
import 'package:easy_beck/beck_test/repository/depression_level_repository.dart';
import 'package:easy_beck/beck_test/repository/question_repository.dart';
import 'package:easy_beck/beck_test/service/beck_test_router.dart';
import 'package:easy_beck/common/map_extensions.dart';
import 'package:rxdart/rxdart.dart';

const _initialState = BeckTestState(
    questionsCount: 0, answers: {}, options: {}, canSubmit: false);

class BeckTestController {
  final QuestionRepository _questionRepository;
  final DepressionLevelRepository _depressionLevelRepository;
  final BeckTestResultRepository _beckTestResultRepository;
  final BeckTestRouter _beckTestRouter;

  final _state = BehaviorSubject<BeckTestState>.seeded(_initialState);
  late final Stream<BeckTestState> state = _state.doOnListen(_load);

  BeckTestController(this._questionRepository, this._depressionLevelRepository,
      this._beckTestRouter, this._beckTestResultRepository);

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

    final depressionLevel =
        await _depressionLevelRepository.getDepressionLevelForPoints(points);

    final result = await _beckTestResultRepository.insert(BeckTestResult(
        id: _beckTestResultRepository.createId(),
        points: points,
        depressionLevel: depressionLevel));

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
