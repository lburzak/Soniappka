import 'package:easy_beck/feature/symptom_page/symptom_page.dart';
import 'package:easy_beck/feature/symptom_page/symptom_page_view_model.dart';
import 'package:easy_beck/feature/symptom_prompt/ui/irritability_prompt.dart';
import 'package:flutter/material.dart';

class IrritabilityPage extends StatelessWidget {
  final SymptomPageViewModel viewModel;

  const IrritabilityPage({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SymptomPage(
        title: "Drażliwość w ciągu dnia",
        description: "Jak oceniasz swój poziom drażliwości?",
        image: const Hero(
            tag: "icon/irritability",
            child:
            Image(height: 100, image: AssetImage("assets/angry-cut.gif"))),
        ratings: irritabilityRatings,
        level: viewModel.level,
        onUpdated: (level) {
          if (level == null) {
            viewModel.unsetLevel();
          } else {
            viewModel.setLevel(level);
          }
        });
  }
}
