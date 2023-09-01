import 'dart:async';

import 'package:easy_beck/feature/dashboard/dashboard_event.dart';
import 'package:easy_beck/feature/dashboard/dashboard_state.dart';
import 'package:easy_beck/feature/dashboard/symptom_type.dart';
import 'package:easy_beck/feature/symptom_tile/anxiety_symptom_tile.dart';
import 'package:easy_beck/feature/symptom_tile/irritability_symptom_tile.dart';
import 'package:easy_beck/feature/symptom_tile/sleepiness_symptom_tile.dart';
import 'package:flutter/material.dart';

class ActionTile extends StatelessWidget {
  const ActionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Card();
  }
}

class Dashboard extends StatelessWidget {
  final Stream<DashboardState> state;
  final EventSink<DashboardEvent> sink;

  const Dashboard({super.key, required this.state, required this.sink});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverList.list(children: [
              IrritabilitySymptomTile(
                state: state.map((event) => event.irritabilityLevel).distinct(),
                onUpdated: (level) =>
                    onLevelUpdated(SymptomType.irritability, level),
              ),
              SleepinessSymptomTile(
                state: state.map((event) => event.sleepinessLevel).distinct(),
                onUpdated: (level) =>
                    onLevelUpdated(SymptomType.sleepiness, level),
              ),
              AnxietySymptomTile(
                state: state.map((event) => event.anxietyLevel).distinct(),
                onUpdated: (level) =>
                    onLevelUpdated(SymptomType.anxiety, level),
              ),
              // SymptomTile(),
              // SymptomTile(),
            ]),
            SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (context, index) => const ActionTile())
          ],
        ));
  }

  void onLevelUpdated(SymptomType symptomType, int? level) {
    if (level == null) {
      sink.add(UnsetLevel(symptomType: symptomType));
    } else {
      sink.add(SetLevel(level: level, symptomType: symptomType));
    }
  }
}
