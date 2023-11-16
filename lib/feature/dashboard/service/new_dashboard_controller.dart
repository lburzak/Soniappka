import 'package:easy_beck/domain/actions/service/calendar.dart';
import 'package:easy_beck/domain/common/day.dart';
import 'package:easy_beck/domain/symptoms/model/symptom_log.dart';
import 'package:easy_beck/domain/symptoms/repository/symptom_repository.dart';
import 'package:easy_beck/domain/actions/use_case/toggle_task.dart';
import 'package:easy_beck/domain/actions/use_case/watch_beck_test_task.dart';
import 'package:easy_beck/domain/beck_test/usecase/check_beck_test_solved.dart';
import 'package:easy_beck/feature/dashboard/model/dashboard_event.dart';
import 'package:easy_beck/feature/dashboard/service/dashboard_router.dart';
import 'package:easy_beck/feature/dashboard/model/dashboard_state.dart';
import 'package:easy_beck/domain/symptoms/model/symptom_type.dart';
import 'package:rxdart/rxdart.dart';

class NewDashboardController {
  final SymptomRepository _anxietyRepository;
  final SymptomRepository _irritabilityRepository;
  final SymptomRepository _sleepinessRepository;
  final ToggleTask _toggleTask;
  final WatchBeckTestTask _watchBeckTestTask;
  final DashboardRouter _router;
  final CheckBeckTestStatusForDay _checkBeckTestSolvedForDay;
  final Calendar _calendar;
  final Day _day;

  Stream<DashboardState> createState() =>
      Stream.value(_day).switchMap((today) => Rx.combineLatest4(
          _anxietyRepository.observeSymptomLevelForDay(today),
          _irritabilityRepository.observeSymptomLevelForDay(today),
          _sleepinessRepository.observeSymptomLevelForDay(today),
          _watchBeckTestTask(),
          (a, b, c, d) => DashboardState(
            day: today.dateTime,
            isToday: _calendar.isToday(_day),
              irritabilityLevel: b,
              sleepinessLevel: c,
              anxietyLevel: a,
              tasks: [d].toList())));

  void handleEvent(DashboardEvent event) {
    switch (event) {
      case SetLevel(symptomType: var type, level: var level):
        _getRepositoryForType(type).upsertSymptomLog(
            SymptomLog(day: _day, level: level));
      case UnsetLevel(symptomType: var type):
        _getRepositoryForType(type).deleteSymptomLog(_day);
      case TaskToggled(task: var task):
        _toggleTask(task);
      case ShowTaskCreator():
        {}
      case BeckTestOpened():
        Future.microtask(() async {
          final solved =
              await _checkBeckTestSolvedForDay(_day);
          if (solved) {
            _router.showBeckTestAlreadySolvedWarning(onProceed: () {
              _router.goToBeckTest();
            });
          } else {
            _router.goToBeckTest();
          }
        });
      case ShowYesterday():
        _router.goToYesterdayDashboard();
      case ShowToday():
        _router.goToTodayDashboard();
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
    required ToggleTask toggleTask,
    required WatchBeckTestTask watchBeckTestTask,
    required DashboardRouter router,
    required CheckBeckTestStatusForDay checkBeckTestSolvedForDay,
    required Calendar calendar,
    required Day day,
  })  : _anxietyRepository = anxietyRepository,
        _irritabilityRepository = irritabilityRepository,
        _sleepinessRepository = sleepinessRepository,
        _toggleTask = toggleTask,
        _watchBeckTestTask = watchBeckTestTask,
        _router = router,
        _checkBeckTestSolvedForDay = checkBeckTestSolvedForDay,
        _calendar = calendar,
        _day = day;
}
