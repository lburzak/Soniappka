import 'package:async/async.dart';
import 'package:easy_beck/beck_test/data/model/beck_schema.dart'
    show BeckSchema, BeckSchemaMapper;
import 'package:easy_beck/beck_test/model/depression_level.dart';
import 'package:easy_beck/beck_test/model/question.dart';
import 'package:easy_beck/beck_test/repository/depression_level_repository.dart';
import 'package:easy_beck/beck_test/repository/question_repository.dart';
import 'package:flutter/services.dart';

class JsonFileBeckRepository
    implements QuestionRepository, DepressionLevelRepository {
  final schemaCache = AsyncMemoizer<BeckSchema>();

  Future<BeckSchema> get schema =>
      schemaCache.runOnce(() => rootBundle.loadStructuredData(
          "assets/beck_prod.json",
          (value) async => BeckSchemaMapper.fromJson(value)));

  @override
  Future<DepressionLevel> getDepressionLevelForPoints(int points) =>
      schema.then((value) => value.results
          .takeWhile((value) => value.threshold < points)
          .last
          .level);

  @override
  Future<Iterable<Question>> getQuestions() =>
      schema.then((value) => value.questions.map((e) => e.toModel()));
}
