import 'package:easy_beck/beck_calendar/beck_calendar_view.dart';
import 'package:easy_beck/dashboard/dashboard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

typedef BeckCalendarViewBuilder = BeckCalendarView Function(BuildContext context);

class Dashboard extends StatelessWidget {
  final Stream<DashboardViewModel> viewModel;
  final BeckCalendarViewBuilder calendarBuilder;

  const Dashboard(
      {super.key, required this.viewModel, required this.calendarBuilder});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Text("Hej Soniu :))", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
              Padding(
                  padding: const EdgeInsets.all(16),
                  child: calendarBuilder(context)),
              StreamBuilder(
                  stream: viewModel.map((model) => model.isTodayTestFilled),
                  builder: (context, isTodayTestFilled) => ElevatedButton.icon(
                        onPressed: () {
                          context.push("/beck-test");
                        },
                        icon: const Icon(Icons.assignment),
                        label: Text(isTodayTestFilled.data == true
                            ? "Powtórz dzisiejszy test"
                            : "Wykonaj test"),
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
