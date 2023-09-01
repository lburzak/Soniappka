import 'package:easy_beck/common/day.dart';
import 'package:easy_beck/feature/dashboard/dashboard_event.dart';
import 'package:easy_beck/feature/dashboard/dashboard_state.dart';
import 'package:easy_beck/feature/dashboard/symptom_type.dart';
import 'package:easy_beck/feature/symptom_prompt/domain/symptom_log.dart';
import 'package:easy_beck/feature/symptom_prompt/domain/symptom_repository.dart';
import 'package:quiver/time.dart';
import 'package:rxdart/rxdart.dart';

class NewDashboardController {
  final SymptomRepository _anxietyRepository;
  final SymptomRepository _irritabilityRepository;
  final SymptomRepository _sleepinessRepository;
  final Clock _clock;

  Stream<DashboardState> createState() =>
      Stream.value(_clock.today()).switchMap((today) => Rx.combineLatest3(
          _anxietyRepository.observeSymptomLevelForDay(today),
          _irritabilityRepository.observeSymptomLevelForDay(today),
          _sleepinessRepository.observeSymptomLevelForDay(today),
          (a, b, c) => DashboardState(
              irritabilityLevel: b, sleepinessLevel: c, anxietyLevel: a)));

  void handleEvent(DashboardEvent event) {
    switch (event) {
      case SetLevel(symptomType: var type, level: var level):
        _getRepositoryForType(type)
            .upsertSymptomLog(SymptomLog(day: _clock.today(), level: level));
      case UnsetLevel(symptomType: var type):
        _getRepositoryForType(type).deleteSymptomLog(_clock.today());
    }
  }

  SymptomRepository _getRepositoryForType(SymptomType type) => switch (type) {
        SymptomType.anxiety => _anxietyRepository,
        SymptomType.irritability => _irritabilityRepository,
        SymptomType.sleepiness => _sleepinessRepository
      };

  const NewDashboardController({
    required SymptomRepository anxietyRepository,
    required SymptomRepository irritabilityRepository,
    required SymptomRepository sleepinessRepository,
    required Clock clock,
  })  : _anxietyRepository = anxietyRepository,
        _irritabilityRepository = irritabilityRepository,
        _sleepinessRepository = sleepinessRepository,
        _clock = clock;
}

extension Today on Clock {
  Day today() => now().toDay();
}
