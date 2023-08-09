import 'package:easy_beck/beck_calendar/beck_calendar_view.dart';
import 'package:easy_beck/common/ui/typed_widget_builder.dart';
import 'package:easy_beck/feature/beck_test_button/ui/beck_test_button.dart';
import 'package:flutter/material.dart';

class JournalPage extends StatelessWidget {
  final TypedWidgetBuilder<BeckCalendarView> calendarBuilder;
  final TypedWidgetBuilder<BeckTestButton> beckTestButtonBuilder;

  const JournalPage(
      {super.key,
      required this.calendarBuilder,
      required this.beckTestButtonBuilder});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [calendarBuilder(context), beckTestButtonBuilder(context)],
    );
  }
}
