import 'package:easy_beck/domain/beck_test/model/answer.dart';
import 'package:easy_beck/domain/common/identifier.dart';

class Question {
  final Identifier id;
  final List<Answer> answers;

  const Question({
    required this.id,
    required this.answers,
  });

  Iterable<String> get answersTexts => answers.map((e) => e.text);
}
