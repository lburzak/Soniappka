import 'package:easy_beck/beck_calendar/beck_calendar_view.dart';
import 'package:easy_beck/beck_test/model/beck_test_result.dart';

class BeckCalendarViewModel {
  final Map<int, BeckTestResult> _testResults;

  const BeckCalendarViewModel({
    required Map<int, BeckTestResult> testResults,
  }) : _testResults = testResults;

  BeckTestResult? getTestResultForDay(DateTime dateTime) =>
      _testResults[dateTime.dayHashCode];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is BeckCalendarViewModel &&
              runtimeType == other.runtimeType &&
              _testResults == other._testResults;

  @override
  int get hashCode => _testResults.hashCode;
}
