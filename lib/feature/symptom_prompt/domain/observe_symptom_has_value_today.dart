import 'package:easy_beck/common/day.dart';
import 'package:easy_beck/feature/symptom_prompt/domain/symptom_repository.dart';
import 'package:quiver/time.dart';

class ObserveSymptomHasValueToday {
  final SymptomRepository _symptomRepository;
  final Clock _clock;

  ObserveSymptomHasValueToday(this._symptomRepository, this._clock);

  Stream<bool> call() {
    final today = _clock.now().toDay();
    return _symptomRepository.observeSymptomHasLevelForDay(today);
  }
}
