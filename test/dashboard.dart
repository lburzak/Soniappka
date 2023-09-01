import 'package:easy_beck/feature/dashboard/dashboard.dart';
import 'package:easy_beck/feature/dashboard/dashboard_event.dart';
import 'package:easy_beck/feature/dashboard/dashboard_state.dart';
import 'package:easy_beck/feature/dashboard/symptom_type.dart';
import 'package:easy_beck/feature/symptom_tile/anxiety_symptom_tile.dart';
import 'package:easy_beck/feature/symptom_tile/irritability_symptom_tile.dart';
import 'package:easy_beck/feature/symptom_tile/sleepiness_symptom_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rxdart/subjects.dart';

void main() async {
  const state =
      DashboardState(irritabilityLevel: 1, sleepinessLevel: 2, anxietyLevel: 3);
  final events = PublishSubject<DashboardEvent>();
  final dashboard = MaterialApp(
      home: Dashboard(state: BehaviorSubject.seeded(state), sink: events));

  testWidgets("shows irritability tile with proper args", (tester) async {
    await tester.pumpWidget(dashboard);
    expectLater(
        tester.firstWidgetByType<IrritabilitySymptomTile>().state, emits(1));
  });

  testWidgets("shows sleepiness tile with proper args", (tester) async {
    await tester.pumpWidget(dashboard);
    expectLater(
        tester.firstWidgetByType<SleepinessSymptomTile>().state, emits(2));
  });

  testWidgets("shows anxiety tile with proper args", (tester) async {
    await tester.pumpWidget(dashboard);
    expectLater(tester.firstWidgetByType<AnxietySymptomTile>().state, emits(3));
  });

  testWidgets("irritability tile level non-null updates emit SetLevel event",
      (tester) async {
    await tester.pumpWidget(dashboard);

    expectLater(events,
        emits(const SetLevel(level: 2, symptomType: SymptomType.irritability)));

    tester.firstWidgetByType<IrritabilitySymptomTile>().onUpdated(2);
  });

  testWidgets("irritability tile level null updates emit UnsetLevel event",
      (tester) async {
    await tester.pumpWidget(dashboard);

    expectLater(
        events, emits(const UnsetLevel(symptomType: SymptomType.irritability)));

    tester.firstWidgetByType<IrritabilitySymptomTile>().onUpdated(null);
  });

  testWidgets("sleepiness tile level non-null updates emit SetLevel event",
      (tester) async {
    await tester.pumpWidget(dashboard);

    expectLater(events,
        emits(const SetLevel(level: 3, symptomType: SymptomType.sleepiness)));

    tester.firstWidgetByType<SleepinessSymptomTile>().onUpdated(3);
  });

  testWidgets("sleepiness tile level null updates emit UnsetLevel event",
      (tester) async {
    await tester.pumpWidget(dashboard);

    expectLater(
        events, emits(const UnsetLevel(symptomType: SymptomType.sleepiness)));

    tester.firstWidgetByType<SleepinessSymptomTile>().onUpdated(null);
  });

  testWidgets("anxiety tile level non-null updates emit SetLevel event",
      (tester) async {
    await tester.pumpWidget(dashboard);

    expectLater(events,
        emits(const SetLevel(level: 4, symptomType: SymptomType.anxiety)));

    tester.firstWidgetByType<AnxietySymptomTile>().onUpdated(4);
  });

  testWidgets("anxiety tile level null updates emit UnsetLevel event",
      (tester) async {
    await tester.pumpWidget(dashboard);

    expectLater(
        events, emits(const UnsetLevel(symptomType: SymptomType.anxiety)));

    tester.firstWidgetByType<AnxietySymptomTile>().onUpdated(null);
  });
}

extension FirstWidget on WidgetTester {
  T firstWidgetByType<T extends Widget>() {
    return firstWidget<T>(find.byType(T));
  }
}
