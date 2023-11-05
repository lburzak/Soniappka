import 'package:easy_beck/common/ui/types/typed_widget_builder.dart';
import 'package:easy_beck/feature/symptoms_chart/ui/symptoms_chart.dart';
import 'package:flutter/material.dart';

class SymptomsChartPage extends StatelessWidget {
  final TypedWidgetBuilder<SymptomsChart> symptomsChartBuilder;

  const SymptomsChartPage({super.key, required this.symptomsChartBuilder});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RotatedBox(
              quarterTurns: 1,
              child: symptomsChartBuilder(context),
            ),
          ),
        ),
      ),
    );
  }
}
