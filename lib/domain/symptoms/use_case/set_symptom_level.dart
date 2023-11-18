import 'package:easy_beck/domain/common/day.dart';
import 'package:easy_beck/domain/symptoms/model/symptom_log.dart';
import 'package:easy_beck/domain/symptoms/repository/symptom_repository.dart';

class SetSymptomLevel {
  final SymptomRepository _symptomRepository;

  SetSymptomLevel(this._symptomRepository);

  Future<void> call({required Day day, required int? level}) async {
    if (level == null) {
      await _symptomRepository.deleteSymptomLog(day);
      return;
    }

    final log = SymptomLog(day: day, level: level);
    await _symptomRepository.upsertSymptomLog(log);
  }
}
