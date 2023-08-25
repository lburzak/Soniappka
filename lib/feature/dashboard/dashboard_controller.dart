import 'package:easy_beck/common/day.dart';
import 'package:easy_beck/feature/dashboard/dashboard_view_model.dart';
import 'package:easy_beck/feature/symptom_prompt/domain/symptom_log.dart';
import 'package:easy_beck/feature/symptom_prompt/domain/symptom_repository.dart';
import 'package:quiver/time.dart';

class DashboardController implements DashboardViewModel {
  final SymptomRepository _anxietyRepository;
  final SymptomRepository _irritabilityRepository;
  final SymptomRepository _sleepinessRepository;
  final Clock _clock;

  @override
  late final anxietyLevel = _anxietyRepository
      .observeSymptomLevelForDay(_clock.now().toDay());
  @override
  late final irritabilityLevel = _irritabilityRepository
      .observeSymptomLevelForDay(_clock.now().toDay());
  @override
  late final sleepinessLevel = _sleepinessRepository
      .observeSymptomLevelForDay(_clock.now().toDay());

  DashboardController({
    required SymptomRepository anxietyRepository,
    required SymptomRepository irritabilityRepository,
    required SymptomRepository sleepinessRepository,
    required Clock clock,
  })  : _anxietyRepository = anxietyRepository,
        _irritabilityRepository = irritabilityRepository,
        _sleepinessRepository = sleepinessRepository,
        _clock = clock;

  @override
  void setAnxiety(int level) {
    _validateLevel(level);
    _anxietyRepository
        .upsertSymptomLog(SymptomLog(day: _clock.now().toDay(), level: level));
  }

  @override
  void setIrritability(int level) {
    _validateLevel(level);
    _irritabilityRepository
        .upsertSymptomLog(SymptomLog(day: _clock.now().toDay(), level: level));
  }

  @override
  void setSleepiness(int level) {
    _validateLevel(level);
    _sleepinessRepository
        .upsertSymptomLog(SymptomLog(day: _clock.now().toDay(), level: level));
  }

  @override
  void unsetAnxiety() {
    _anxietyRepository.deleteSymptomLog(_clock.now().toDay());
  }

  @override
  void unsetIrritability() {
    _irritabilityRepository.deleteSymptomLog(_clock.now().toDay());
  }

  @override
  void unsetSleepiness() {
    _sleepinessRepository.deleteSymptomLog(_clock.now().toDay());
  }

  void _validateLevel(int level) {
    if (level < 1 && level > 5) {
      throw ArgumentError.value(
          level, "level", "level must be within 1..5 range");
    }
  }
}
