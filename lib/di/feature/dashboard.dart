import 'dart:async';

import 'package:easy_beck/di/common.dart';
import 'package:easy_beck/di/domain.dart';
import 'package:easy_beck/di/hive.dart';
import 'package:easy_beck/feature/dashboard/model/dashboard_event.dart';
import 'package:easy_beck/feature/dashboard/service/new_dashboard_controller.dart';
import 'package:easy_beck/feature/dashboard/ui/dashboard.dart';
import 'package:easy_beck/feature/dashboard/ui/material_dashboard_router.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_stream_listener/flutter_stream_listener.dart';

class InjectedDashboard extends StatefulWidget {
  const InjectedDashboard({super.key});

  @override
  State<InjectedDashboard> createState() => _InjectedDashboardState();
}

class _InjectedDashboardState extends State<InjectedDashboard> {
  late final router = MaterialDashboardRouter(context: context);

  late final controller = NewDashboardController(
      sleepinessRepository: hiveDependencyGraph.sleepinessRepository,
      irritabilityRepository: hiveDependencyGraph.irritabilityRepository,
      anxietyRepository: hiveDependencyGraph.anxietyRepository,
      toggleTask: domainDependencyGraph.toggleTask,
      watchBeckTestTask: domainDependencyGraph.watchBeckTestTask,
      clock: commonDependencyGraph.clock,
      router: router,
      checkBeckTestSolved: domainDependencyGraph.checkBeckTestSolved);

  late final events = StreamController<DashboardEvent>.broadcast();

  @override
  Widget build(BuildContext context) {
    return StreamListener<DashboardEvent>(
        stream: events.stream,
        onData: controller.handleEvent,
        child: Dashboard(
            state: controller.createState().asBroadcastStream(),
            sink: events.sink));
  }
}
