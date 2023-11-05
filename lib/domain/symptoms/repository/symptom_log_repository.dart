import 'package:easy_beck/domain/symptoms/model/symptom_log.dart';

abstract interface class SymptomLogRepository {
  Stream<Iterable<SymptomLog>> watchAll();
}
