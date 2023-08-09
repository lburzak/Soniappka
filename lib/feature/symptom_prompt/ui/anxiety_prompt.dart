import 'package:easy_beck/common/ui/rating_selector.dart';
import 'package:easy_beck/feature/symptom_prompt/widget/prompt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AnxietyPrompt extends HookWidget {
  final void Function(int level) onSubmitted;

  const AnxietyPrompt({super.key, required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    final currentLevel = useState(2);

    return Prompt(
        title: "Niepokój w ciągu dnia",
        icon: SizedBox(
            width: 100, height: 100, child: Image.asset("assets/anxiety.png")),
        body: Column(
          children: [
            const Text(
              "Jak oceniasz swój poziom niepokoju?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
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
          "Czułam się całkowicie spokojna i zrelaksowana. Nie było wtedy miejsca na niepokojące myśli ani lęki."),
  Rating(
      title: "Spokojna",
      description:
          "Odczuwałam pewien spokój, ale mogły pojawić się lekkie uczucia niepewności czy niespokoju. Jednak były one na tyle minimalne, że nie przeszkadzały mi w codziennych aktywnościach."),
  Rating(
      title: "Umiarkowanie zaniepokojona",
      description:
          "Odczuwałam większą dawkę niepewności i zmartwień. Miałam pewne lęki i obawy związane z sytuacjami życiowymi, ale nadal potrafiłam funkcjonować stosunkowo normalnie."),
  Rating(
      title: "Bardzo zaniepokojona",
      description:
          "Odczuwałam silne uczucia niepokoju i lęku. Moje myśli były skoncentrowane na negatywnych scenariuszach, co mogło utrudniać mi normalne funkcjonowanie i podejmowanie decyzji."),
  Rating(
      title: "Skrajnie zaniepokojona",
      description:
          "Byłam przytłoczona lękiem i niepokojem, co prowadziło do znacznego pogorszenia jakości życia. Zmaganie się z codziennymi wyzwaniami stało się trudne, a moje emocje wydawały się niekontrolowane."),
];
