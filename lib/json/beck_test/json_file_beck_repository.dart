import 'package:async/async.dart';
import 'package:easy_beck/domain/beck_test/model/depression_level.dart';
import 'package:easy_beck/domain/beck_test/model/question.dart';
import 'package:easy_beck/domain/beck_test/repository/depression_level_repository.dart';
import 'package:easy_beck/domain/beck_test/repository/question_repository.dart';
import 'package:easy_beck/json/beck_test/model/beck_schema.dart'
    show BeckSchema, BeckSchemaMapper;
import 'package:flutter/services.dart';

class JsonFileBeckRepository
    implements QuestionRepository, DepressionLevelRepository {
  final schemaCache = AsyncMemoizer<BeckSchema>();

  Future<BeckSchema> get _schema =>
      schemaCache.runOnce(() => rootBundle.loadStructuredData(
          "assets/beck_questionnaire.json",
          (value) async => BeckSchemaMapper.fromJson(value)));

  @override
  Future<DepressionLevel> getDepressionLevelForPoints(int points) =>
      _schema.then((value) => value.results
          .takeWhile((value) => value.threshold < points)
          .last
          .level);

  @override
  Future<Iterable<Question>> getQuestions() =>
      _schema.then((value) => value.questions.map((e) => e.toModel()));
}
