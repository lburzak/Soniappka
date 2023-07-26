import 'package:easy_beck/beck_test/model/beck_answers_schema.dart';

abstract interface class BeckAnswersSchemaRepository {
  Future<BeckAnswersSchema> getSchema();
}
