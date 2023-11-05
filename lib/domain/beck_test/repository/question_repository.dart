import 'package:easy_beck/domain/beck_test/model/question.dart';

abstract interface class QuestionRepository {
  Future<Iterable<Question>> getQuestions();
}
