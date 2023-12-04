import 'package:easy_beck/domain/common/day.dart';
import 'package:easy_beck/domain/symptoms/repository/symptom_repository.dart';

class WatchSymptomLevel {
  final SymptomRepository _symptomRepository;

  WatchSymptomLevel(this._symptomRepository);

  Stream<int?> call({required Day day}) {
    return _symptomRepository.observeSymptomLevelForDay(day);
  }
}
