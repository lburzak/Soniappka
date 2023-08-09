import 'package:easy_beck/common/day.dart';
import 'package:easy_beck/feature/symptom_prompt/domain/symptom_log.dart';
import 'package:easy_beck/feature/symptom_prompt/domain/symptom_repository.dart';
import 'package:hive/hive.dart';

class HiveSymptomRepository implements SymptomRepository {
  final Box<int> _symptomBox;

  HiveSymptomRepository(this._symptomBox);

  @override
  Future<void> upsertSymptomLog(SymptomLog symptomLog) async {
    _symptomBox.put(symptomLog.day.hashCode, symptomLog.level);
  }

  @override
  Stream<bool> observeSymptomHasLevelForDay(Day day) async* {
    yield _symptomBox.containsKey(day.hashCode);
    yield* _symptomBox
        .watch(key: day.hashCode)
        .map((event) => !event.deleted)
        .distinct();
  }
}
