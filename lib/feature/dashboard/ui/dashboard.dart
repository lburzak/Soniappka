import 'dart:async';

import 'package:easy_beck/feature/actions/widget/task_grid.dart';
import 'package:easy_beck/feature/dashboard/model/dashboard_event.dart';
import 'package:easy_beck/feature/dashboard/model/dashboard_state.dart';
import 'package:easy_beck/feature/dashboard/model/symptom_type.dart';
import 'package:easy_beck/feature/symptom_tile/ui/anxiety_symptom_tile.dart';
import 'package:easy_beck/feature/symptom_tile/ui/irritability_symptom_tile.dart';
import 'package:easy_beck/feature/symptom_tile/ui/sleepiness_symptom_tile.dart';
import 'package:easy_beck/l10n/localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              sliver: SliverFixedExtentList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(context.l10n.symptoms,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge),
                              IconButton(
                                  onPressed: () {
                                    context.push("/journal");
                                  },
                                  icon: const Icon(Icons.bar_chart))
                            ],
                          ),
                      childCount: 1),
                  itemExtent: 40),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              sliver: SliverList.list(children: [
                IrritabilitySymptomTile(
                  state:
                      state.map((event) => event.irritabilityLevel).distinct(),
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
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              sliver: SliverFixedExtentList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => Text(context.l10n.therapy,
                          style: Theme.of(context).textTheme.headlineLarge),
                      childCount: 1),
                  itemExtent: 40),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              sliver: StreamBuilder(
                stream: state.map((event) => event.tasks),
                builder: (context, snapshot) => TasksGrid(
                  tasks: snapshot.data ?? [],
                  onNewTask: () => sink.add(ShowTaskCreator()),
                  onToggleTask: (task) => sink.add(TaskToggled(task: task)),
                  onBeckTestOpen: () => sink.add(BeckTestOpened()),
                ),
              ),
            )
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
