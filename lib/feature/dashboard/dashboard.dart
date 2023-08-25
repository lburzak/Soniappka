import 'package:easy_beck/feature/dashboard/dashboard_view_model.dart';
import 'package:easy_beck/feature/symptom_tile/anxiety_symptom_tile.dart';
import 'package:easy_beck/feature/symptom_tile/irritability_symptom_tile.dart';
import 'package:easy_beck/feature/symptom_tile/sleepiness_symptom_tile.dart';
import 'package:flutter/material.dart';

class ActionTile extends StatelessWidget {
  const ActionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Card();
  }
}

class Dashboard extends StatelessWidget {
  final DashboardViewModel _viewModel;

  const Dashboard({super.key, required DashboardViewModel viewModel})
      : _viewModel = viewModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverList.list(children: [
              IrritabilitySymptomTile(
                state: _viewModel.irritabilityLevel,
                onUpdated: (level) {
                  if (level == null) {
                    _viewModel.unsetIrritability();
                  } else {
                    _viewModel.setIrritability(level);
                  }
                },
              ),
              SleepinessSymptomTile(
                state: _viewModel.sleepinessLevel,
                onUpdated: (level) {
                  if (level == null) {
                    _viewModel.unsetSleepiness();
                  } else {
                    _viewModel.setSleepiness(level);
                  }
                },
              ),
              AnxietySymptomTile(state: _viewModel.anxietyLevel,
                onUpdated: (level) {
                  if (level == null) {
                    _viewModel.unsetAnxiety();
                  } else {
                    _viewModel.setAnxiety(level);
                  }
                },),
              // SymptomTile(),
              // SymptomTile(),
            ]),
            SliverGrid.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (context, index) => ActionTile())
          ],
        ));
  }
}
