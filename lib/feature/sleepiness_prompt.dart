import 'package:easy_beck/common/ui/rating_selector.dart';
import 'package:easy_beck/feature/prompt.dart';
import 'package:flutter/material.dart';

class SleepinessPrompt extends StatelessWidget {
  const SleepinessPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return Prompt(
        title: "Senność w ciągu dnia",
        icon: SizedBox(
            width: 100, height: 100, child: Image.asset("assets/sleeping.png")),
        body: Column(
          children: [
            const Text(
              "Jak oceniasz swój poziom senności?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
                height: 210,
                child: RatingSelector(
                  ratings: ratings,
                  onLevelSelected: (level) {},
                )),
          ],
        ),
        onSubmitted: () {});
  }
}

const ratings = [
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
