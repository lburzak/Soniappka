import 'package:easy_beck/beck_test/model/answer.dart';
import 'package:easy_beck/beck_test/model/identifier.dart';

class Question {
  final Identifier id;
  final List<Answer> answers;

  const Question({
    required this.id,
    required this.answers,
  });

  Iterable<String> get answersTexts => answers.map((e) => e.text);
}
