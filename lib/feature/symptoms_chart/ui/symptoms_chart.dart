import 'package:easy_beck/feature/symptoms_chart/service/symptoms_chart_state.dart';
import 'package:easy_beck/l10n/localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

const _bdiAxisName = "bdiAxis";

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
              axisLabelFormatter:
                  (AxisLabelRenderDetails axisLabelRenderArgs) =>
                      ChartAxisLabel(
                          DateFormat(axisLabelRenderArgs.currentDateFormat)
                              .format(DateTime.fromMillisecondsSinceEpoch(
                                  axisLabelRenderArgs.value.toInt())),
                          const TextStyle()),
            ),
            primaryYAxis: NumericAxis(
              title: AxisTitle(
                  text: context.l10n.chartAxis_symptomsLevel,
                  textStyle: Theme.of(context).textTheme.labelLarge),
              axisLine: const AxisLine(color: Colors.black),
              majorTickLines: const MajorTickLines(color: Colors.black),
              labelStyle: const TextStyle(color: Colors.black),
              majorGridLines: const MajorGridLines(color: Colors.black12),
            ),
            axes: [
              NumericAxis(
                  name: _bdiAxisName,
                  title: AxisTitle(
                      text: context.l10n.beckTestIndicator,
                      textStyle: Theme.of(context).textTheme.labelLarge),
                  axisLine: const AxisLine(color: Colors.black),
                  majorTickLines: const MajorTickLines(color: Colors.black),
                  labelStyle: const TextStyle(color: Colors.black),
                  majorGridLines: const MajorGridLines(color: Colors.black12),
                  opposedPosition: true),
            ],
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
                  legendItemText: context.l10n.symptomAnxiety),
              StackedColumnSeries(
                  dataSource: data.symptomsChartDataPoints,
                  xValueMapper: (value, _) => value.dateTime,
                  yValueMapper: (value, _) => value.irritability,
                  legendItemText: context.l10n.symptomIrritability),
              StackedColumnSeries(
                  dataSource: data.symptomsChartDataPoints,
                  xValueMapper: (value, _) => value.dateTime,
                  yValueMapper: (value, _) => value.sleepiness,
                  legendItemText: context.l10n.symptomSleepiness),
              SplineSeries(
                  dataSource: data.testResults,
                  color: Colors.redAccent,
                  width: 5,
                  splineType: SplineType.cardinal,
                  legendItemText: context.l10n.beckTestIndicator,
                  xValueMapper: (value, _) => value.submissionDateTime,
                  yValueMapper: (value, _) => value.points,
                  yAxisName: _bdiAxisName)
            ],
          );
        });
  }
}
