class BeckTestState {
  final int questionsCount;
  final Map<int, int?> answers;
  final Map<int, List<String>> options;
  final bool canSubmit;

  const BeckTestState({
    required this.questionsCount,
    required this.answers,
    required this.options,
    this.canSubmit = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BeckTestState &&
          runtimeType == other.runtimeType &&
          questionsCount == other.questionsCount &&
          answers == other.answers &&
          options == other.options &&
          canSubmit == other.canSubmit);

  @override
  int get hashCode =>
      questionsCount.hashCode ^
      answers.hashCode ^
      options.hashCode ^
      canSubmit.hashCode;

  BeckTestState copyWith({
    int? questionsCount,
    Map<int, int?>? answers,
    Map<int, List<String>>? options,
    bool? canSubmit,
  }) {
    return BeckTestState(
      questionsCount: questionsCount ?? this.questionsCount,
      answers: answers ?? this.answers,
      options: options ?? this.options,
      canSubmit: canSubmit ?? this.canSubmit,
    );
  }
}
