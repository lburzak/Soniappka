import 'package:easy_beck/feature/symptom_prompt/domain/symptom_log.dart';
import 'package:easy_beck/feature/symptoms_chart/service/symptoms_chart_state.dart';

/**
 * Combines logs into a single list, to prevent gaps in dates
 */
class SymptomsChartDataMerger {
  List<SymptomsChartDataPoint> merge(
      {required Iterable<SymptomLog> sleepinessLogs,
        required Iterable<SymptomLog> irritabilityLogs,
        required Iterable<SymptomLog> anxietyLogs}) {
    final sleepinessMap = sleepinessLogs.toMap();
    final irritabilityMap = irritabilityLogs.toMap();
    final anxietyMap = anxietyLogs.toMap();
    final dates = [...sleepinessLogs, ...irritabilityLogs, ...anxietyLogs]
        .map((e) => e.day.dateTime)
        .toSet();
    return [
      for (var dateTime in dates)
        SymptomsChartDataPoint(
          dateTime: dateTime,
          anxiety: anxietyMap[dateTime] ?? 0,
          sleepiness: sleepinessMap[dateTime] ?? 0,
          irritability: irritabilityMap[dateTime] ?? 0,
        )
    ];
  }
}

extension _SymptomLogsToMap on Iterable<SymptomLog> {
  Map<DateTime, int> toMap() {
    return {for (var item in this) item.day.dateTime: item.level};
  }
}
