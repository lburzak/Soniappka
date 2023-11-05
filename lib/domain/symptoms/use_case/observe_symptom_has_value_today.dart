import 'package:easy_beck/domain/common/day.dart';
import 'package:easy_beck/domain/symptoms/repository/symptom_repository.dart';
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
