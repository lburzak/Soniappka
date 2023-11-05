import 'package:easy_beck/common/day.dart';
import 'package:easy_beck/domain/symptoms/model/symptom_log.dart';

abstract interface class SymptomRepository {
  Future<void> upsertSymptomLog(SymptomLog symptomLog);
  Stream<bool> observeSymptomHasLevelForDay(Day day);
  Stream<int?> observeSymptomLevelForDay(Day day);
  Future<void> deleteSymptomLog(Day day);
}
