import 'package:easy_beck/beck_calendar/beck_calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Text("Hej Soniu :))"),
              BeckCalendarView(),
              ElevatedButton.icon(
                onPressed: () {
                  context.go("/beck-test");
                },
                icon: const Icon(Icons.assignment),
                label: const Text("Wykonaj test"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
