import 'dart:async';

import 'package:collection/collection.dart';
import 'package:easy_beck/beck_test/repository/beck_answers_schema.dart';
import 'package:easy_beck/beck_test/model/state.dart';
import 'package:rxdart/rxdart.dart';

class BeckTestController {
  final BeckAnswersSchemaRepository _beckAnswersSchemaRepository;

  final _state = BehaviorSubject<BeckTestState>.seeded(Loading());
  late final Stream<BeckTestState> state = _state.doOnListen(_load);

  BeckTestController(this._beckAnswersSchemaRepository);

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

  void submit() {
    final currentState = _state.value;
    if (currentState is Solving) {
      _state.add(Finished(
          pointsObtained: currentState.answers.values.whereNotNull().fold(
              0, (previousValue, answerIndex) => previousValue + answerIndex),
          description: "Pales"));
    }
  }

  Future<void> _load() async {
    final answersSchema = await _beckAnswersSchemaRepository.getSchema();

    final answers =
        Map.fromEntries(List.generate(21, (index) => MapEntry(index, null)));

    final options = Map.fromEntries(List.generate(
        21,
        (index) => MapEntry(
            index, answersSchema.getAnswers(questionIndex: index) ?? [])));

    _state.add(Solving(questionsCount: 21, answers: answers, options: options));
  }
}

extension MapTransform<K, V> on Map<K, V> {
  Map<K, V> withValueAt({required K key, required V value}) {
    final newMap = Map<K, V>.from(this);
    newMap[key] = value;
    return newMap;
  }
}
