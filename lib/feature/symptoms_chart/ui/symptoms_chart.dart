import 'package:easy_beck/feature/symptoms_chart/service/symptoms_chart_state.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
            primaryXAxis: DateTimeAxis(
              axisLine: const AxisLine(color: Colors.black),
              majorGridLines: const MajorGridLines(width: 0),
              majorTickLines: const MajorTickLines(color: Colors.black),
              labelStyle: const TextStyle(color: Colors.black),
              minorGridLines: const MinorGridLines(color: Colors.black),
              interval: 1,
              labelAlignment: LabelAlignment.start,
              intervalType: DateTimeIntervalType.days,
              axisLabelFormatter: (AxisLabelRenderDetails
                      axisLabelRenderArgs) =>
                  ChartAxisLabel(
                      DateFormat(axisLabelRenderArgs.currentDateFormat, "pl").format(DateTime.fromMillisecondsSinceEpoch(axisLabelRenderArgs.value.toInt())),
                      const TextStyle()),
            ),
            primaryYAxis: NumericAxis(
              axisLine: const AxisLine(color: Colors.black),
              majorTickLines: const MajorTickLines(color: Colors.black),
              labelStyle: const TextStyle(color: Colors.black),
              majorGridLines: const MajorGridLines(color: Colors.black12),
            ),
            zoomPanBehavior: ZoomPanBehavior(
                enablePinching: true,
                enablePanning: true,
                zoomMode: ZoomMode.x),
            legend: const Legend(isVisible: true),
            margin: const EdgeInsets.all(24),
            plotAreaBorderWidth: 0,
            plotAreaBorderColor: Colors.black,
            series: <CartesianSeries>[
              StackedColumnSeries(
                  dataSource: data.symptomsChartDataPoints,
                  xValueMapper: (value, _) => value.dateTime,
                  yValueMapper: (value, _) => value.anxiety,
                  legendItemText: "Niepokój"),
              StackedColumnSeries(
                  dataSource: data.symptomsChartDataPoints,
                  xValueMapper: (value, _) => value.dateTime,
                  yValueMapper: (value, _) => value.irritability,
                  legendItemText: "Drażliwość"),
              StackedColumnSeries(
                  dataSource: data.symptomsChartDataPoints,
                  xValueMapper: (value, _) => value.dateTime,
                  yValueMapper: (value, _) => value.sleepiness,
                  legendItemText: "Senność"),
              SplineSeries(
                  dataSource: data.testResults,
                  color: Colors.lightGreen,
                  width: 3,
                  legendItemText: "BDI",
                  xValueMapper: (value, _) => value.submissionDateTime,
                  yValueMapper: (value, _) => value.points / 5)
            ],
          );
        });
  }
}
