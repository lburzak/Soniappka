import 'package:easy_beck/common/ui/rating_selector.dart';
import 'package:easy_beck/feature/symptom_prompt/widget/prompt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SleepinessPrompt extends HookWidget {
  final void Function(int level) onSubmitted;

  const SleepinessPrompt({super.key, required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    final currentLevel = useState(2);

    return Prompt(
        title: "Senność w ciągu dnia",
        icon: SizedBox(
            width: 100, height: 100, child: Hero(tag: "icon/sleepiness", child: Image.asset("assets/sleeping.png"))),
        body: Column(
          children: [
            const Text(
              "Jak oceniasz swój poziom senności?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
                height: 210,
                child: RatingSelector(
                  ratings: sleepinessRatings,
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

const sleepinessRatings = [
  Rating(
      title: "Bardzo rozbudzona",
      description:
          "Czułam się pełna energii i całkowicie obudzona. Byłam skoncentrowana i gotowa do działania."),
  Rating(
      title: "Rozbudzona",
      description:
          "Byłam raczej aktywna, ale mogłam odczuwać lekkie zmęczenie. Mój poziom energii był na zadowalającym poziomie."),
  Rating(
      title: "Umiarkowanie rozbudzona",
      description:
          "Mogłam odczuwać pewne zmęczenie, które wpływało na moją koncentrację. Byłam jeszcze w stanie wykonywać codzienne zadania, ale z mniejszą werwą."),
  Rating(
      title: "Senna / zmęczona",
      description:
          "Odczuwałam znaczne zmęczenie i senność. Wykonywanie zadań wymagało ode mnie większego wysiłku, a poziom energii był niski."),
  Rating(
      title: "Bardzo senna / zmęczona",
      description:
          "Byłam bardzo senna, a wykonywanie nawet prostych czynności stawało się trudne. Bardzo potrzebowałam odpoczynku i snu.")
];
