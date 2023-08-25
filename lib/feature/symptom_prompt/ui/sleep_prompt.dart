import 'package:easy_beck/common/ui/rating_selector.dart';
import 'package:easy_beck/feature/symptom_prompt/widget/prompt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SleepPrompt extends HookWidget {
  final void Function(int level) onSubmitted;

  const SleepPrompt({super.key, required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    final currentLevel = useState(2);
    final currentHours = useState(8);

    return Prompt(
        title: "Sen w nocy",
        icon: SizedBox(
            width: 100, height: 100, child: Image.asset("assets/sleeping.png")),
        body: Column(
          children: [
            const Text("Ile godzin spałaś?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ValueListenableBuilder(
              valueListenable: currentHours,
              builder: (context, value, child) => SfSlider(
                  value: value,
                  interval: 2.0,
                  showTicks: true,
                  showLabels: true,
                  stepSize: 1,
                  onChanged: (value) {
                    currentHours.value = value;
                  },
                  min: 0.0,
                  max: 16.0),
            ),
            const SizedBox(height: 32),
            const Text("Jak oceniasz swój sen?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(
                height: 210,
                child: RatingSelector(
                  ratings: sleepRatings,
                  onLevelSelected: (level) {
                    currentLevel.value = level!;
                  },
                )),
          ],
        ),
        onSubmitted: () {
          onSubmitted(currentLevel.value);
        });
  }
}

const sleepRatings = [
  Rating(
      title: "Bardzo słaby",
      description:
          "Spałam źle, przebudzałam się wielokrotnie w nocy i trudno mi było wrócić do snu. Rano byłam wyjątkowo zmęczona i miała trudności z funkcjonowaniem."),
  Rating(
      title: "Słaby",
      description:
          "Miałam problemy z zasypianiem lub budziłam się kilka razy w nocy. Sen był niespokojny, a rano czułam się zmęczona i nie w pełni wypoczęta."),
  Rating(
      title: "Umiarkowany",
      description:
          "Spałam w miarę dobrze, ale mogłam odczuwać lekkie trudności z zasypianiem lub krótkotrwałe wybudzenia. Rano mogłam czuć się trochę zmęczona."),
  Rating(
      title: "Dobry",
      description:
          "Spałam dobrze, ale mogłam mieć krótkie epizody przebudzeń w ciągu nocy. Mimo to, ogólnie czułam się wypoczęta po przebudzeniu."),
  Rating(
      title: "Bardzo dobry",
      description:
          "Spałam spokojnie i głęboko przez całą noc. Nie miałam problemów z zasypianiem ani budzeniem się w nocy. Obudziłam się wypoczęta i pełna energii.")
];
