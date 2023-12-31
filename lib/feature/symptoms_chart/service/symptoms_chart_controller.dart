import 'package:collection/collection.dart';
import 'package:easy_beck/domain/beck_test/repository/beck_test_result_repository.dart';
import 'package:easy_beck/domain/symptoms/repository/symptom_log_repository.dart';
import 'package:easy_beck/feature/symptoms_chart/service/symptoms_chart_data_merger.dart';
import 'package:easy_beck/feature/symptoms_chart/service/symptoms_chart_state.dart';
import 'package:rxdart/rxdart.dart';

class SymptomsChartController {
  final SymptomLogRepository _sleepinessLogRepository;
  final SymptomLogRepository _anxietyLogRepository;
  final SymptomLogRepository _irritabilityLogRepository;
  final BeckTestResultRepository _beckTestResultRepository;
  final symptomsChartDataMerger = SymptomsChartDataMerger();

  late final state = Rx.combineLatest4(
      _sleepinessLogRepository.watchAll(),
      _anxietyLogRepository.watchAll(),
      _irritabilityLogRepository.watchAll(),
      _beckTestResultRepository.watchAll(),
      (sleepinessLogs, anxietyLogs, irritabilityLogs, beckTestResults) =>
          SymptomsChartState(
              symptomsChartDataPoints: symptomsChartDataMerger.merge(
                  sleepinessLogs: sleepinessLogs,
                  irritabilityLogs: irritabilityLogs,
                  anxietyLogs: anxietyLogs),
              testResults: beckTestResults.toList().sorted((a, b) =>
                  a.submissionDateTime.compareTo(b.submissionDateTime))));

  SymptomsChartController(
      this._sleepinessLogRepository,
      this._anxietyLogRepository,
      this._irritabilityLogRepository,
      this._beckTestResultRepository);
}
