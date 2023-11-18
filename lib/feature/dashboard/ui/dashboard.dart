import 'dart:async';

import 'package:easy_beck/common/ui/theme/colors.dart';
import 'package:easy_beck/common/ui/theme/theme_getter.dart';
import 'package:easy_beck/common/ui/widget/stream_visibility.dart';
import 'package:easy_beck/feature/actions/widget/task_grid.dart';
import 'package:easy_beck/feature/dashboard/model/dashboard_event.dart';
import 'package:easy_beck/feature/dashboard/model/dashboard_state.dart';
import 'package:easy_beck/domain/symptoms/model/symptom_type.dart';
import 'package:easy_beck/feature/symptom_tile/ui/anxiety_symptom_tile.dart';
import 'package:easy_beck/feature/symptom_tile/ui/irritability_symptom_tile.dart';
import 'package:easy_beck/feature/symptom_tile/ui/sleepiness_symptom_tile.dart';
import 'package:easy_beck/l10n/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:morphable_shape/morphable_shape.dart';

class Dashboard extends HookWidget {
  final Stream<DashboardState> state;
  final EventSink<DashboardEvent> sink;

  const Dashboard({super.key, required this.state, required this.sink});

  @override
  Widget build(BuildContext context) {
    final isToday = useStream(state.map((event) => event.isToday));

    return Container(
      color: isToday.data == true
          ? context.theme.colorScheme.background
          : context.theme.colors.backgroundVariant,
      child: SafeArea(
          bottom: false,
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                  padding: EdgeInsets.zero,
                  sliver: SliverToBoxAdapter(
                    child: Stack(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: StreamVisibility(
                                visibilityStream:
                                    state.map((event) => event.isToday),
                                child: GestureDetector(
                                    onTap: () => sink.add(ShowYesterday()),
                                    child: const FoldedCornerPrevious()))),
                        Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: StreamBuilder(
                                  stream: state.map((event) => event.day),
                                  builder: (context, snapshot) {
                                    return Text(
                                        snapshot.hasData
                                            ? DateFormat.MMMMEEEEd()
                                                .format(snapshot.requireData)
                                            : "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium);
                                  }),
                            )),
                        Align(
                            alignment: Alignment.topRight,
                            child: StreamBuilder<bool>(
                                stream: state.map((event) => event.isToday),
                                builder: (context, snapshot) =>
                                    switch (snapshot.data) {
                                      false => GestureDetector(
                                          onTap: () => sink.add(ShowToday()),
                                          child: const FoldedCornerNext()),
                                      _ => const Padding(
                                          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                          child: StatisticsButton(),
                                        ),
                                    })),
                      ],
                    ),
                  )),
              SliverPadding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                sliver: SliverFixedExtentList(
                    delegate: SliverChildBuilderDelegate(
                        (context, index) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(context.l10n.symptoms,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge),
                              ],
                            ),
                        childCount: 1),
                    itemExtent: 40),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                sliver: SliverList.list(children: [
                  IrritabilitySymptomTile(
                    state: state
                        .map((event) => event.irritabilityLevel)
                        .distinct(),
                    onUpdated: (level) =>
                        onLevelUpdated(SymptomType.irritability, level),
                  ),
                  SleepinessSymptomTile(
                    state:
                        state.map((event) => event.sleepinessLevel).distinct(),
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
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
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
          )),
    );
  }

  void onLevelUpdated(SymptomType symptomType, int? level) {
    if (level == null) {
      sink.add(UnsetLevel(symptomType: symptomType));
    } else {
      sink.add(SetLevel(level: level, symptomType: symptomType));
    }
  }
}

class StatisticsButton extends StatelessWidget {
  const StatisticsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          context.push("/journal");
        },
        icon: const Icon(Icons.bar_chart));
  }
}

class FoldedCornerNext extends StatelessWidget {
  const FoldedCornerNext({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.theme.colorScheme.background,
      elevation: 4,
      shape: TriangleShapeBorder(
        point3: DynamicOffset(
            _foldedCornerSize.toPXLength, _foldedCornerSize.toPXLength),
      ),
      clipBehavior: Clip.antiAlias,
      child: const SizedBox(
        width: _foldedCornerSize,
        height: _foldedCornerSize,
      ),
    );
  }
}

class FoldedCornerPrevious extends StatelessWidget {
  const FoldedCornerPrevious({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _foldedCornerSize,
      height: _foldedCornerSize,
      color: context.theme.colors.backgroundVariant,
      child: Material(
        color: context.theme.colors.backgroundDark,
        elevation: 4,
        shape: TriangleShapeBorder(
          point1: DynamicOffset(0.toPXLength, _foldedCornerSize.toPXLength),
          point3: DynamicOffset(
              _foldedCornerSize.toPXLength, _foldedCornerSize.toPXLength),
        ),
        clipBehavior: Clip.antiAlias,
        child: const SizedBox(
          width: _foldedCornerSize,
          height: _foldedCornerSize,
        ),
      ),
    );
  }
}

const _foldedCornerSize = 50.0;
