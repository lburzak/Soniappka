import 'package:easy_beck/common/day.dart';
import 'package:easy_beck/feature/symptom_prompt/domain/symptom_log.dart';

abstract interface class SymptomRepository {
  Future<void> upsertSymptomLog(SymptomLog symptomLog);
  Stream<bool> observeSymptomHasLevelForDay(Day day);
}
