import 'package:easy_beck/beck_calendar/beck_calendar_view.dart';
import 'package:easy_beck/dashboard/dashboard_view_model.dart';
import 'package:easy_beck/mood_tracker/mood_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

typedef BeckCalendarViewBuilder = BeckCalendarView Function(
    BuildContext context);
typedef MoodPickerBuilder = MoodPicker Function(BuildContext context);

class Dashboard extends StatelessWidget {
  final Stream<DashboardViewModel> viewModel;
  final BeckCalendarViewBuilder calendarBuilder;
  final MoodPickerBuilder moodPickerBuilder;

  const Dashboard(
      {super.key,
      required this.viewModel,
      required this.calendarBuilder,
      required this.moodPickerBuilder});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // const Text("Hej Soniu :))", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),,
                _Section(
                  label: "Twoje samopoczucie",
                  children: [
                    Container(
                      height: 120,
                      decoration: const BoxDecoration(
                          border: Border.fromBorderSide(BorderSide())),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24, bottom: 8),
                      child: Text(
                        "Jak się czujesz w tym momencie?".toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: moodPickerBuilder(context))
                  ],
                ),
                _Section(label: "Dziennik depresji", children: [
                  calendarBuilder(context),
                  StreamBuilder(
                      stream: viewModel.map((model) => model.isTodayTestFilled),
                      builder: (context, isTodayTestFilled) =>
                          ElevatedButton.icon(
                            onPressed: () {
                              context.push("/beck-test");
                            },
                            icon: const Icon(Icons.assignment),
                            label: Text(isTodayTestFilled.data == true
                                ? "Powtórz dzisiejszy test"
                                : "Wykonaj test"),
                          )),
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String label;
  final List<Widget> children;

  const _Section({super.key, required this.label, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(label, style: const TextStyle(fontSize: 32))),
          ...children
        ],
      ),
    );
  }
}
