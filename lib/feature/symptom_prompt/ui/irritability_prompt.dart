import 'package:easy_beck/common/ui/rating_selector.dart';
import 'package:easy_beck/feature/symptom_prompt/widget/prompt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class IrritabilityPrompt extends HookWidget {
  final void Function(int level) onSubmitted;

  const IrritabilityPrompt({super.key, required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    final currentLevel = useState(2);

    return Prompt(
        title: "Drażliwość w ciągu dnia",
        icon: SizedBox(
            width: 200, height: 200, child: Image.asset("assets/angry.gif")),
        body: Column(
          children: [
            const Text("Jak oceniasz swój poziom drażliwości?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(
                height: 210,
                child: RatingSelector(
                  ratings: ratings,
                  initialLevel: 2,
                  onLevelSelected: (level) {
                    currentLevel.value = level;
                  },
                )),
          ],
        ),
        onSubmitted: () {
          onSubmitted(currentLevel.value);
        });
  }
}

const ratings = [
  Rating(
      title: "Bardzo spokojna",
      description:
          "Byłam wyciszona, cierpliwa i nie reagowałam negatywnie na drobne niedogodności czy stresory. Czułam się zrelaksowana i spokojna."),
  Rating(
      title: "Spokojna",
      description:
          "Byłam ogólnie spokojna, ale mogłam być lekko zdenerwowana lub zirytowana w odpowiedzi na określone sytuacje. Moje reakcje były zwykle kontrolowane i nie eskalowały."),
  Rating(
      title: "Neutralna / umiarkowana",
      description:
          "Mogłam odczuwać wzmożoną drażliwość w odpowiedzi na zdarzenia i sytuacje. Mogły pojawić się krótkotrwałe momenty frustracji, jednak zazwyczaj potrafiłam zachować kontrolę nad emocjami."),
  Rating(
      title: "Drażliwa / zirytowana",
      description:
          "Byłam bardziej drażliwa i łatwo mogłam się denerwować na różne wydarzenia lub ludzi. Jeśli nie zapanowałam nad emocjami, moje reakcje mogły być bardziej gwałtowne."),
  Rating(
      title: "Bardzo drażliwa / wybuchowa",
      description:
          "Byłam bardzo podenerwowana, agresywna lub wybuchowa nawet w odpowiedzi na drobne wydarzenia. Trudno mi było zachować spokój, a moje reakcje mogły być nadmiernie ekspresyjne i destrukcyjne.")
];
