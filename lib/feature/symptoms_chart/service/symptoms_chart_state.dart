import 'package:easy_beck/beck_test/model/beck_test_result.dart';
import 'package:easy_beck/feature/symptom_prompt/domain/symptom_log.dart';

class SymptomsChartState {
  final List<SymptomLog> sleepinessLogs;
  final List<SymptomLog> irritabilityLogs;
  final List<SymptomLog> anxietyLogs;
  final List<BeckTestResult> testResults;

  const SymptomsChartState({
    required this.sleepinessLogs,
    required this.irritabilityLogs,
    required this.anxietyLogs,
    required this.testResults,
  });
}
