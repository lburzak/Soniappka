import 'dart:async';

import 'package:easy_beck/di/common.dart';
import 'package:easy_beck/di/domain.dart';
import 'package:easy_beck/di/feature/actions.dart';
import 'package:easy_beck/di/feature/symptom_tile.dart';
import 'package:easy_beck/di/hive.dart';
import 'package:easy_beck/domain/common/day.dart';
import 'package:easy_beck/feature/dashboard/model/dashboard_event.dart';
import 'package:easy_beck/feature/dashboard/service/new_dashboard_controller.dart';
import 'package:easy_beck/feature/dashboard/ui/dashboard.dart';
import 'package:easy_beck/feature/dashboard/ui/material_dashboard_router.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_stream_listener/flutter_stream_listener.dart';

class InjectedDashboard extends StatefulWidget {
  final Day day;

  const InjectedDashboard({super.key, required this.day});

  @override
  State<InjectedDashboard> createState() => _InjectedDashboardState();
}

class _InjectedDashboardState extends State<InjectedDashboard> {
  late final router = MaterialDashboardRouter(
      context: context, clock: commonDependencyGraph.clock);

  late final controller = NewDashboardController(
      sleepinessRepository: hiveDependencyGraph.sleepinessRepository,
      irritabilityRepository: hiveDependencyGraph.irritabilityRepository,
      anxietyRepository: hiveDependencyGraph.anxietyRepository,
      toggleTask: domainDependencyGraph.toggleTask,
      watchBeckTestTask: domainDependencyGraph.watchBeckTestTask,
      day: widget.day,
      calendar: commonDependencyGraph.calendar,
      router: router,
      checkBeckTestSolvedForDay:
          domainDependencyGraph.checkBeckTestStatusForDay);

  late final events = StreamController<DashboardEvent>.broadcast();

  @override
  Widget build(BuildContext context) {
    return StreamListener<DashboardEvent>(
        stream: events.stream,
        onData: controller.handleEvent,
        child: Dashboard(
          day: widget.day,
          isToday: commonDependencyGraph.calendar.isToday(widget.day),
          onGoToYesterday: router.goToYesterdayDashboard,
          onGoToToday: router.goToTodayDashboard,
          symptomTiles: [
            InjectedIrritabilitySymptomTile(day: widget.day),
            InjectedSleepinessSymptomTile(day: widget.day),
            InjectedAnxietySymptomTile(day: widget.day),
          ],
          tasksGrid: InjectedTasksGrid(day: widget.day),
        ));
  }

  @override
  void dispose() {
    events.close();
    super.dispose();
  }
}
