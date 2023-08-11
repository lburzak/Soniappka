import 'dart:math';

import 'package:easy_beck/beck_test/data/in_memory_beck_test_result_repository.dart';
import 'package:easy_beck/beck_test/model/beck_test_result.dart';
import 'package:easy_beck/beck_test/model/depression_level.dart';
import 'package:easy_beck/common/day.dart';
import 'package:easy_beck/feature/symptom_prompt/domain/symptom_log.dart';
import 'package:easy_beck/feature/symptoms_chart/domain/beck_test_result_repository.dart';
import 'package:easy_beck/feature/symptoms_chart/domain/symptom_log_repository.dart';
import 'package:easy_beck/feature/symptoms_chart/service/symptoms_chart_state.dart';
import 'package:quiver/time.dart';
import 'package:rxdart/rxdart.dart';

final rand = Random();

class SymptomsChartController {
  final SymptomLogRepository _sleepinessLogRepository;
  final SymptomLogRepository _anxietyLogRepository;
  final SymptomLogRepository _irritabilityLogRepository;
  final BeckTestResultRepository _beckTestResultRepository;

  late final state = Rx.combineLatest4(
      _sleepinessLogRepository.watchAll(),
      _anxietyLogRepository.watchAll(),
      _irritabilityLogRepository.watchAll(),
      _beckTestResultRepository.watchAll(),
      (sleepinessLogs, anxietyLogs, irritabilityLogs, beckTestResults) =>
          SymptomsChartState(
              sleepinessLogs: sleepinessLogs.toList(),
              irritabilityLogs: irritabilityLogs.toList(),
              anxietyLogs: anxietyLogs.toList(),
              testResults: beckTestResults.toList()));

  SymptomsChartController(this._sleepinessLogRepository,
      this._anxietyLogRepository, this._irritabilityLogRepository, this._beckTestResultRepository);
}

final fakeState = SymptomsChartState(
    testResults: List.generate(
        30,
        (index) => BeckTestResult(
            id: InMemoryBeckTestId.fresh(),
            points: rand.nextInt(60),
            depressionLevel: DepressionLevel.mild,
            submissionDateTime: const Clock().daysAgo(index))),
    anxietyLogs: List.generate(
        30,
        (index) => SymptomLog(
            day: DateTime.now().subtract(Duration(days: index)).toDay(),
            level: rand.nextInt(4))).reversed.toList(),
    irritabilityLogs: List.generate(
        30,
        (index) => SymptomLog(
            day: DateTime.now().subtract(Duration(days: index)).toDay(),
            level: rand.nextInt(4))).reversed.toList(),
    sleepinessLogs: List.generate(30, (index) => SymptomLog(day: DateTime.now().subtract(Duration(days: index)).toDay(), level: rand.nextInt(4))).reversed.toList());
