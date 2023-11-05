import 'package:easy_beck/feature/beck_test/model/question.dart';

abstract interface class QuestionRepository {
  Future<Iterable<Question>> getQuestions();
}
