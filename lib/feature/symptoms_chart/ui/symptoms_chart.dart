import 'package:easy_beck/feature/symptoms_chart/service/symptoms_chart_state.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SymptomsChart extends StatelessWidget {
  final Stream<SymptomsChartState> state;

  const SymptomsChart({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: state,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          final data = snapshot.requireData;

          return SfCartesianChart(
            primaryXAxis: DateTimeAxis(),
            primaryYAxis: CategoryAxis(
              interval: 1,
            ),
            zoomPanBehavior: ZoomPanBehavior(
                enablePinching: true,
                enablePanning: true,
                zoomMode: ZoomMode.x),
            legend: const Legend(isVisible: true),
            series: <CartesianSeries>[
              StackedColumnSeries(
                  dataSource: data.anxietyLogs,
                  xValueMapper: (value, _) => value.day.dateTime,
                  yValueMapper: (value, _) => value.level,
                  legendItemText: "Niepokój"),
              StackedColumnSeries(
                  dataSource: data.irritabilityLogs,
                  xValueMapper: (value, _) => value.day.dateTime,
                  yValueMapper: (value, _) => value.level,
                  legendItemText: "Drażliwość"),
              StackedColumnSeries(
                  dataSource: data.sleepinessLogs,
                  xValueMapper: (value, _) => value.day.dateTime,
                  yValueMapper: (value, _) => value.level,
                  legendItemText: "Senność"),
              SplineSeries(
                  dataSource: data.testResults,
                  color: Colors.lightGreen,
                  width: 3,

                  xValueMapper: (value, _) => value.submissionDateTime,
                  yValueMapper: (value, _) => value.points / 5)
            ],
          );
        });
  }
}
