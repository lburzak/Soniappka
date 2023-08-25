import 'package:easy_beck/feature/symptom_page/symptom_page.dart';
import 'package:easy_beck/feature/symptom_page/symptom_page_view_model.dart';
import 'package:easy_beck/feature/symptom_prompt/ui/irritability_prompt.dart';
import 'package:flutter/material.dart';

class AnxietyPage extends StatelessWidget {
  final SymptomPageViewModel viewModel;

  const AnxietyPage({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SymptomPage(
        title: "Niepokój w ciągu dnia",
        description: "Jak oceniasz swój poziom niepokoju?",
        image: const Hero(
            tag: "icon/anxiety",
            child:
                Image(height: 100, image: AssetImage("assets/anxiety-new.png"))),
        ratings: irritabilityRatings,
        viewModel: viewModel);
  }
}
