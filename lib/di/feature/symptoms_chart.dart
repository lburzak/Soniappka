import 'package:easy_beck/di/hive.dart';
import 'package:easy_beck/feature/symptoms_chart/service/symptoms_chart_controller.dart';
import 'package:easy_beck/feature/symptoms_chart/ui/symptoms_chart.dart';
import 'package:easy_beck/feature/symptoms_chart/ui/symptoms_chart_page.dart';
import 'package:flutter/widgets.dart';

class InjectedSymptomsChartPage extends StatefulWidget {

  const InjectedSymptomsChartPage({super.key});

  @override
  State<InjectedSymptomsChartPage> createState() => _InjectedSymptomsChartPageState();
}

class _InjectedSymptomsChartPageState extends State<InjectedSymptomsChartPage> {
  late final controller = SymptomsChartController(
      hiveDependencyGraph.sleepinessRepository,
      hiveDependencyGraph.anxietyRepository,
      hiveDependencyGraph.irritabilityRepository,
      hiveDependencyGraph.beckTestResultRepository);

  @override
  Widget build(BuildContext context) {
    return SymptomsChartPage(
      symptomsChartBuilder: (context) =>
          SymptomsChart(state: controller.state),
    );
  }
}
