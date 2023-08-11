import 'package:easy_beck/feature/symptom_prompt/domain/symptom_log.dart';

abstract interface class SymptomLogRepository {
  Stream<Iterable<SymptomLog>> watchAll();
}
