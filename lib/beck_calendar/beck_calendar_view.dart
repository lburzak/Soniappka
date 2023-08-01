import 'package:easy_beck/beck_test/model/depression_level.dart';
import 'package:easy_beck/common/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class BeckCalendarViewModel {
  final Map<int, DepressionLevel> _testResults;

  const BeckCalendarViewModel({
    required Map<int, DepressionLevel> testResults,
  }) : _testResults = testResults;

  DepressionLevel? getTestResultForDay(DateTime dateTime) =>
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

class BeckCalendarView extends StatelessWidget {
  final BeckCalendarViewModel viewModel;

  const BeckCalendarView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return TableCalendar<DepressionLevel>(
        focusedDay: DateTime.now(),
        eventLoader: (day) =>
            viewModel.getTestResultForDay(day)?.toList() ?? [],
        calendarBuilders: CalendarBuilders(
            singleMarkerBuilder: (context, day, event) => Icon(
                  Icons.assignment,
                  size: 12,
                  color: getMarkerColor(context, event),
                )),
        headerStyle: const HeaderStyle(formatButtonVisible: false),
        firstDay: DateTime.now().subtract(Duration(days: 50)),
        lastDay: DateTime.now().add(Duration(days: 50)));
  }

  Color getMarkerColor(BuildContext context, DepressionLevel depressionLevel) {
    return switch (depressionLevel) {
      DepressionLevel.none => Colors.white,
      DepressionLevel.mild => Colors.yellow.shade900,
      DepressionLevel.moderate => Colors.orange.shade900,
      DepressionLevel.severe => Colors.red.shade900,
    };
  }
}

extension DayHash on DateTime {
  int get dayHashCode => year.hashCode ^ month.hashCode ^ day.hashCode;
}
