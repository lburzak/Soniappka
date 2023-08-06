import 'package:easy_beck/common/ui/rating_selector.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SleepPrompt extends StatelessWidget {
  const SleepPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child:
                    Text("Sen w nocy", style: GoogleFonts.amaticSc().copyWith(fontSize: 32, fontWeight: FontWeight.bold))),
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 28),
              child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.asset("assets/sleeping.png")),
            ),
            const Text("Ile godzin spałaś?"),
            _SleepHoursSlider(),
            const SizedBox(height: 32),
            const Text("Jak oceniasz swój sen?"),
            SizedBox(
              height: 210,
                child: RatingSelector(ratings: ratings, onLevelSelected: (level) {},)),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.done),
              label: const Text("Zatwierdź"),
              style: const ButtonStyle(
                  surfaceTintColor: MaterialStatePropertyAll(Colors.green)),
            )
          ],
        ),
      ),
    );
  }
}

class _SleepHoursSlider extends StatefulWidget {
  @override
  State<_SleepHoursSlider> createState() => _SleepHoursSliderState();
}

class _SleepHoursSliderState extends State<_SleepHoursSlider> {
  double _value = 8;

  @override
  Widget build(BuildContext context) {
    return SfSlider(
        value: _value,
        interval: 2.0,
        showTicks: true,
        showLabels: true,
        stepSize: 1,
        onChanged: (value) {
          setState(() {
            _value = value;
          });
        },
        min: 0.0,
        max: 16.0);
  }
}

const ratings = [
  Rating(
      title: "Bardzo niski",
      description:
      "Spałam źle, przebudzałam się wielokrotnie w nocy i trudno mi było wrócić do snu. Rano byłam wyjątkowo zmęczona i miała trudności z funkcjonowaniem."),
  Rating(
      title: "Niski",
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
