import 'dart:async';

import 'package:collection/collection.dart';
import 'package:easy_beck/beck_test/model/state.dart';
import 'package:easy_beck/beck_test/repository/depression_level_repository.dart';
import 'package:easy_beck/beck_test/repository/question_repository.dart';
import 'package:rxdart/rxdart.dart';

class BeckTestController {
  final QuestionRepository _questionRepository;
  final DepressionLevelRepository _depressionLevelRepository;

  final _state = BehaviorSubject<BeckTestState>.seeded(Loading());
  late final Stream<BeckTestState> state = _state.doOnListen(_load);

  BeckTestController(this._questionRepository, this._depressionLevelRepository);

  void selectAnswer(int questionIndex, int answerIndex) {
    final currentState = _state.value;
    if (currentState is Solving) {
      _state.add(currentState.copyWith(
          answers: currentState.answers
              .withValueAt(key: questionIndex, value: answerIndex),
          canSubmit: currentState.answers.entries
              .whereNot((element) => element.key == questionIndex)
              .every((element) => element.value != null)));
    }
  }

  void submit() async {
    final currentState = _state.value;
    if (currentState is Solving) {
      final points = currentState.answers.values
          .whereNotNull()
          .fold(0, (previousValue, answerIndex) => previousValue + answerIndex);
      _state.add(Finished(
          pointsObtained: points,
          depressionLevel: await _depressionLevelRepository
              .getDepressionLevelForPoints(points)));
    }
  }

  Future<void> _load() async {
    final questions = await _questionRepository.getQuestions();

    final answers = Map.fromEntries(
        List.generate(questions.length, (index) => MapEntry(index, null)));

    final options = questions.mapIndexed(
        (index, question) => MapEntry(index, question.answersTexts.toList()));

    _state.add(Solving(
        questionsCount: questions.length,
        answers: answers,
        options: options.collectToMap()));
  }
}

extension MapTransform<K, V> on Map<K, V> {
  Map<K, V> withValueAt({required K key, required V value}) {
    final newMap = Map<K, V>.from(this);
    newMap[key] = value;
    return newMap;
  }
}

extension MapFromEntries<K, V> on Iterable<MapEntry<K, V>> {
  Map<K, V> collectToMap() => Map.fromEntries(this);
}
