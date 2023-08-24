import 'package:easy_beck/common/ui/rating_selector.dart';
import 'package:easy_beck/feature/symptom_prompt/ui/anxiety_prompt.dart';
import 'package:easy_beck/feature/symptom_prompt/ui/irritability_prompt.dart';
import 'package:easy_beck/feature/symptom_prompt/ui/sleepiness_prompt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class SymptomTile extends HookWidget {
  final String title;
  final List<Rating> ratings;
  final ImageProvider image;
  final void Function() onExpanded;
  final String tag;

  const SymptomTile(
      {super.key,
        required this.tag,
      required this.ratings,
      required this.image,
      required this.onExpanded,
      required this.title});

  @override
  Widget build(BuildContext context) {
    final level = useState(2);

    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox.square(
              dimension: 60,
              child: Hero(
                tag: tag,
                child: Image(image: image),
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ValueListenableBuilder(
                  valueListenable: level,
                  builder: (context, value, _) => Text(value > 0 ? ratings[value - 1].title : "Nieokreślone")),
              SizedBox(
                height: 30,
                child: ValueListenableBuilder(
                  valueListenable: level,
                  builder: (context, value, _) => SfSliderTheme(
                    data: SfSliderThemeData(
                      thumbRadius: 8,
                      thumbColor: value > 0 ? null : Colors.grey
                    ),
                    child: SfSlider(
                        value: value,
                        interval: 1.0,
                        showTicks: false,
                        showLabels: false,
                        showDividers: true,
                        stepSize: 1,
                        onChanged: (value) {
                          level.value = value.toInt();
                          // onLevelSelected(value.toInt());
                        },
                        min: 0.0,
                        max: ratings.length),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                IconButton(onPressed: onExpanded, icon: const Icon(Icons.info)),
          )
        ],
      ),
    );
  }
}

class ActionTile extends StatelessWidget {
  const ActionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Card();
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverList.list(children: [
              SymptomTile(
                tag: "icon/irritability",
                title: "Drażliwość",
                ratings: irritabilityRatings,
                image: const AssetImage("assets/angry-cut.gif"),
                onExpanded: () { context.push("/symptom/irritability"); },
              ),
              SymptomTile(
                tag: "icon/sleepiness",
                title: "Senność",
                ratings: sleepinessRatings,
                image: const AssetImage("assets/sleeping.png"),
                onExpanded: () { context.push("/symptom/sleepiness"); },
              ),
              SymptomTile(
                tag: "icon/anxiety",
                title: "Niepokój",
                ratings: anxietyRatings,
                image: const AssetImage("assets/anxiety-new.png"),
                onExpanded: () { context.push("/symptom/anxiety"); },
              ),
              // SymptomTile(),
              // SymptomTile(),
            ]),
            SliverGrid.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (context, index) => ActionTile())
          ],
        ));
  }
}
