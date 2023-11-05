import 'package:easy_beck/domain/common/day.dart';
import 'package:easy_beck/domain/symptoms/model/symptom_log.dart';
import 'package:easy_beck/domain/symptoms/repository/symptom_repository.dart';
import 'package:easy_beck/domain/symptoms/repository/symptom_log_repository.dart';
import 'package:hive/hive.dart';

class HiveSymptomRepository implements SymptomRepository, SymptomLogRepository {
  final Box<SymptomLog> _symptomBox;

  HiveSymptomRepository(this._symptomBox);

  @override
  Future<void> upsertSymptomLog(SymptomLog symptomLog) async {
    _symptomBox.put(symptomLog.day.hashCode, symptomLog);
  }

  @override
  Future<void> deleteSymptomLog(Day day) async {
    _symptomBox.delete(day.hashCode);
  }

  @override
  Stream<bool> observeSymptomHasLevelForDay(Day day) async* {
    yield _symptomBox.containsKey(day.hashCode);
    yield* _symptomBox
        .watch(key: day.hashCode)
        .map((event) => !event.deleted)
        .distinct();
  }

  @override
  Stream<Iterable<SymptomLog>> watchAll() async* {
    yield _symptomBox.values;
    yield* _symptomBox.watch().map((event) => _symptomBox.values);
  }

  @override
  Stream<int?> observeSymptomLevelForDay(Day day) async* {
    yield _symptomBox.get(day.hashCode)?.level;
    yield* _symptomBox
        .watch(key: day.hashCode)
        .map((event) => _symptomBox.get(day.hashCode)?.level)
        .distinct();
  }
}
