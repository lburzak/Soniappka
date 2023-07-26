import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:easy_beck/beck_test/model/beck_answers_schema.dart';
import 'package:easy_beck/beck_test/repository/beck_answers_schema.dart';
import 'package:flutter/services.dart';

class JsonFileBeckAnswersSchemaRepository
    implements BeckAnswersSchemaRepository {
  @override
  Future<BeckAnswersSchema> getSchema() =>
      rootBundle.loadStructuredData("assets/beck.json", _parseSchemaFromJson);

  Future<BeckAnswersSchema> _parseSchemaFromJson(String source) async {
    final json = jsonDecode(source);
    final List<dynamic> questions = json["questions"];
    final Map<int, List<String>> answersData = Map.fromEntries(questions.mapIndexed((index, question) {
      final Map<String, dynamic> answersMap = question["answers"];
      return MapEntry(index, answersMap.values.cast<String>().toList());
    }));
    return BeckAnswersSchema(data: answersData);
  }
}
