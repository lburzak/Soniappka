import 'package:easy_beck/feature/symptom_page/symptom_page.dart';
import 'package:easy_beck/feature/symptom_page/symptom_page_view_model.dart';
import 'package:easy_beck/feature/symptom_prompt/ui/sleepiness_prompt.dart';
import 'package:flutter/material.dart';

class SleepinessPage extends StatelessWidget {
  final SymptomPageViewModel viewModel;

  const SleepinessPage({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SymptomPage(
        title: "Senność w ciągu dnia",
        description: "Jak oceniasz swój poziom senności?",
        image: const Hero(
            tag: "icon/sleepiness",
            child:
                Image(height: 100, image: AssetImage("assets/sleeping.png"))),
        ratings: sleepinessRatings,
        viewModel: viewModel);
  }
}
