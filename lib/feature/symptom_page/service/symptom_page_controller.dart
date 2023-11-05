import 'package:easy_beck/common/day.dart';
import 'package:easy_beck/feature/symptom_page/model/symptom_page_view_model.dart';
import 'package:easy_beck/feature/symptom_prompt/domain/symptom_log.dart';
import 'package:easy_beck/feature/symptom_prompt/domain/symptom_repository.dart';
import 'package:quiver/time.dart';

class SymptomPageController implements SymptomPageViewModel {
  final SymptomRepository _symptomRepository;
  final Clock _clock;

  SymptomPageController(this._symptomRepository, this._clock);

  @override
  Stream<int?> get level =>
      _symptomRepository.observeSymptomLevelForDay(_clock.now().toDay());

  @override
  void setLevel(int level) {
    _symptomRepository.upsertSymptomLog(
        SymptomLog(day: _clock.now().toDay(), level: level));
  }

  @override
  void unsetLevel() {
    _symptomRepository.deleteSymptomLog(_clock.now().toDay());
  }
}
