import 'package:dart_mappable/dart_mappable.dart';
import 'package:easy_beck/beck_test/model/answer.dart';
import 'package:easy_beck/beck_test/model/depression_level.dart';
import 'package:easy_beck/beck_test/model/identifier.dart';
import 'package:easy_beck/beck_test/model/question.dart' as model;

part 'beck_schema.mapper.dart';

class JsonQuestionId implements Identifier {
  final int value;

  JsonQuestionId(this.value);
}

@MappableClass()
class BeckSchema with BeckSchemaMappable {
  final List<Result> results;
  final List<Question> questions;

  BeckSchema(this.results, this.questions);
}

@MappableClass(includeCustomMappers: [DepressionLevelMapper()])
class Result with ResultMappable {
  final int threshold;
  final DepressionLevel level;

  Result(this.threshold, this.level);
}

@MappableClass()
class Question with QuestionMappable {
  final int id;
  final Map<String, String> answers;

  Question(this.id, this.answers);

  model.Question toModel() => model.Question(
      id: JsonQuestionId(id),
      answers: answers.entries
          .map((entry) =>
              Answer(points: int.parse(entry.key), text: entry.value))
          .toList());
}

class DepressionLevelMapper extends SimpleMapper<DepressionLevel> {
  const DepressionLevelMapper();

  @override
  DepressionLevel decode(dynamic value) {
    return switch (value) {
      "MILD" => DepressionLevel.mild,
      "MODERATE" => DepressionLevel.moderate,
      "SEVERE" => DepressionLevel.severe,
      "NONE" || _ => DepressionLevel.none,
    };
  }

  @override
  dynamic encode(DepressionLevel self) {
    return self.toString();
  }
}
