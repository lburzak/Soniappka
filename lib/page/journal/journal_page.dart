import 'package:easy_beck/beck_calendar/beck_calendar_view.dart';
import 'package:easy_beck/common/ui/typed_widget_builder.dart';
import 'package:easy_beck/feature/beck_test_button/ui/beck_test_button.dart';
import 'package:easy_beck/feature/symptoms_chart/ui/symptoms_chart.dart';
import 'package:flutter/material.dart';

class JournalPage extends StatelessWidget {
  final TypedWidgetBuilder<BeckCalendarView> calendarBuilder;
  final TypedWidgetBuilder<BeckTestButton> beckTestButtonBuilder;
  final TypedWidgetBuilder<SymptomsChart> symptomsChartBuilder;

  const JournalPage(
      {super.key,
      required this.calendarBuilder,
      required this.beckTestButtonBuilder,
      required this.symptomsChartBuilder});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              calendarBuilder(context),
              beckTestButtonBuilder(context),
              symptomsChartBuilder(context),
            ],
          ),
        ),
      ),
    );
  }
}
