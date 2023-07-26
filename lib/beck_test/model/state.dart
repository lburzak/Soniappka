sealed class BeckTestState {
  const BeckTestState();
}

class Finished extends BeckTestState {
  final int pointsObtained;
  final String description;

  const Finished({
    required this.pointsObtained,
    required this.description,
  });
}

class Loading extends BeckTestState {}

class Solving extends BeckTestState {
  final int questionsCount;
  final Map<int, int?> answers;
  final Map<int, List<String>> options;
  final bool canSubmit;

  Solving({
    required this.questionsCount,
    required this.answers,
    required this.options,
    this.canSubmit = false,
  }) {
    if (answers.length != questionsCount) {}

    if (options.length != questionsCount) {}
  }

  Solving copyWith({
    int? questionsCount,
    Map<int, int?>? answers,
    Map<int, List<String>>? options,
    bool? canSubmit,
  }) {
    return Solving(
      questionsCount: questionsCount ?? this.questionsCount,
      answers: answers ?? this.answers,
      options: options ?? this.options,
      canSubmit: canSubmit ?? this.canSubmit,
    );
  }
}
