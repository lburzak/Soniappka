import 'package:easy_beck/di/feature/beck_test.dart';
import 'package:easy_beck/di/feature/dashboard.dart';
import 'package:easy_beck/di/feature/symptom_page.dart';
import 'package:easy_beck/di/feature/symptoms_chart.dart';
import 'package:easy_beck/router/app_router.dart';
import 'package:flutter/material.dart';

late final RouterDependencyGraph routerDependencyGraph =
    RouterDependencyGraph._();

class RouterDependencyGraph {
  late final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "root");
  late final shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "shell");

  late final appRouter = AppRouter(
      rootNavigatorKey: rootNavigatorKey,
      shellNavigatorKey: shellNavigatorKey,
      dashboardBuilder: (context, day) => InjectedDashboard(day: day),
      journalBuilder: (context) => const InjectedSymptomsChartPage(),
      scaffoldBuilder: (context, child) => Scaffold(body: child),
      beckTestBuilder: (context) => const InjectedBeckTest(),
      beckTestResultBuilder: (context, idParameter) =>
          InjectedBeckTestResultPage(idParameter: idParameter),
      irritabilityPageBuilder: (context) => const InjectedIrritabilityPage(),
      sleepinessPageBuilder: (context) => const InjectedSleepinessPage(),
      anxietyPageBuilder: (context) => const InjectedAnxietyPage());

  RouterDependencyGraph._();
}
