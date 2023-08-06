import 'package:easy_beck/beck_calendar/beck_calendar_view.dart';
import 'package:easy_beck/dashboard/dashboard_view_model.dart';
import 'package:easy_beck/feature/sleep_prompt/sleep_prompt.dart';
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
            padding: const EdgeInsets.all(4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // const Text("Hej Soniu :))", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),,
                SleepPrompt(),
                _Section(
                  label: "Twoje samopoczucie",
                  children: [
                    SizedBox(
                        width: 200,
                        height: 200,
                        child: Image.asset("assets/angry.gif")),
                    SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.asset("assets/anxiety.png")),
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

  const _Section({required this.label, required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(label, style: const TextStyle(fontSize: 32))),
            ...children
          ],
        ),
      ),
    );
  }
}
