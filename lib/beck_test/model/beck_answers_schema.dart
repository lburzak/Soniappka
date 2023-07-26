class BeckAnswersSchema {
  final Map<int, List<String>> _data;

  List<String>? getAnswers({required int questionIndex}) => _data[questionIndex];

  const BeckAnswersSchema({
    required Map<int, List<String>> data,
  }) : _data = data;
}
