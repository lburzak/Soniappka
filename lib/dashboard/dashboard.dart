import 'package:easy_beck/beck_calendar/beck_calendar_view.dart';
import 'package:easy_beck/beck_test/model/depression_level.dart';
import 'package:easy_beck/dashboard/dashboard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Dashboard extends StatelessWidget {
  final Stream<DashboardViewModel> viewModel;

  const Dashboard({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Text("Hej Soniu :))"),
              BeckCalendarView(
                viewModel: BeckCalendarViewModel(testResults: {
                  DateTime(2023, DateTime.august, 3).dayHashCode:
                      DepressionLevel.mild
                }),
              ),
              StreamBuilder<bool>(
                  stream: viewModel.map((model) => model.isTodayTestFilled),
                  builder: (context, snapshot) {
                    return ElevatedButton.icon(
                      onPressed: () {
                        context.push("/beck-test");
                      },
                      icon: const Icon(Icons.assignment),
                      label: Text(snapshot.data == true
                          ? "Powtórz dzisiejszy test"
                          : "Wykonaj test"),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
