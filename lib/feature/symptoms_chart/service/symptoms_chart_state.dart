import 'package:easy_beck/beck_test/model/beck_test_result.dart';

class SymptomsChartDataPoint {
  final DateTime dateTime;
  final int sleepiness;
  final int irritability;
  final int anxiety;


  const SymptomsChartDataPoint({
    required this.dateTime,
    required this.sleepiness,
    required this.irritability,
    required this.anxiety,
  });

  SymptomsChartDataPoint copyWith({
    DateTime? dateTime,
    int? sleepiness,
    int? irritability,
    int? anxiety,
  }) {
    return SymptomsChartDataPoint(
      dateTime: dateTime ?? this.dateTime,
      sleepiness: sleepiness ?? this.sleepiness,
      irritability: irritability ?? this.irritability,
      anxiety: anxiety ?? this.anxiety,
    );
  }
}

class SymptomsChartState {
  final List<SymptomsChartDataPoint> symptomsChartDataPoints;
  final List<BeckTestResult> testResults;

  const SymptomsChartState({
    required this.symptomsChartDataPoints,
    required this.testResults,
  });
}
