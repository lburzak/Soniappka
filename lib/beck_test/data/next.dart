import 'dart:convert';
import 'dart:io';

import 'package:easy_beck/beck_test/data/model/beck_schema.dart';

void main() {
  final data = File("assets/beck.json");
  final str = data.readAsStringSync();
  final beckSchema = BeckSchemaMapper.fromJson(str);
  final newSchema = {
    "answers": beckSchema.questions.map((e) => e.answers.values.toList()).toList(),
    "results": beckSchema.results
  };

  print(JsonEncoder.withIndent("   ").convert(newSchema));
}
