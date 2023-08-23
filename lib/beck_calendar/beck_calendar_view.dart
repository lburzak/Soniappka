import 'package:easy_beck/beck_calendar/beck_calendar_view_model.dart';
import 'package:easy_beck/beck_test/model/beck_test_result.dart';
import 'package:easy_beck/beck_test/model/depression_level.dart';
import 'package:easy_beck/common/common_extensions.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class BeckCalendarView extends StatelessWidget {
  final Stream<BeckCalendarViewModel> viewModel;

  const BeckCalendarView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BeckCalendarViewModel>(
      stream: viewModel,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return TableCalendar<BeckTestResult>(
              locale: Localizations.localeOf(context).languageCode,
              focusedDay: DateTime.now(),
              eventLoader: (day) =>
                  snapshot.requireData.getTestResultForDay(day)?.toList() ?? [],
              calendarBuilders: CalendarBuilders(
                  singleMarkerBuilder: (context, day, event) => Icon(
                        Icons.assignment,
                        size: 12,
                        color: getMarkerColor(context, event.depressionLevel),
                      )),
              headerStyle: const HeaderStyle(formatButtonVisible: false),
              firstDay: DateTime.now().subtract(Duration(days: 50)),
              lastDay: DateTime.now().add(Duration(days: 50)));
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
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
