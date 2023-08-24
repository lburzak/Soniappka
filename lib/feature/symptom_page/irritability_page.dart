import 'package:easy_beck/feature/symptom_page/symptom_page.dart';
import 'package:easy_beck/feature/symptom_prompt/ui/irritability_prompt.dart';
import 'package:flutter/material.dart';

class IrritabilityPage extends StatelessWidget {
  const IrritabilityPage({super.key});

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
        onUpdated: (l) {});
  }
}
