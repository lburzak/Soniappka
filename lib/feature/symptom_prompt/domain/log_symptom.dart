import 'package:easy_beck/common/day.dart';
import 'package:easy_beck/feature/symptom_prompt/domain/symptom_log.dart';
import 'package:easy_beck/feature/symptom_prompt/domain/symptom_repository.dart';
import 'package:quiver/time.dart';

class LogSymptom {
  final SymptomRepository _symptomRepository;
  final Clock _clock;

  LogSymptom(this._symptomRepository, this._clock);

  Future<void> call(int level) async {
    final symptomLog = SymptomLog(day: _clock.now().toDay(), level: level);
    _symptomRepository.upsertSymptomLog(symptomLog);
  }
}
