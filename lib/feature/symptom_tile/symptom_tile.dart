import 'package:easy_beck/common/ui/rating_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../symptom_prompt/ui/sleep_prompt.dart';

class SymptomTile extends HookWidget {
  const SymptomTile({super.key});

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
                dimension: 50, child: Image.asset("assets/sleepy.png")),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Senność: ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ValueListenableBuilder(
                  valueListenable: level,
                  builder: (context, value, _) =>
                      Text(sleepRatings[value].title)),
              SizedBox(
                  child: ValueListenableBuilder(
                valueListenable: level,
                builder: (context, value, _) => SfSlider(
                    value: value,
                    interval: 1.0,
                    showTicks: false,
                    showLabels: false,
                    showDividers: true,
                    stepSize: 1,
                    thumbIcon: SizedBox.shrink(),
                    onChanged: (value) {
                      level.value = value.toInt();
                      // onLevelSelected(value.toInt());
                    },
                    min: 0.0,
                    max: sleepRatings.length - 1),
              )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.info)),
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

void main() {
  runApp(TestApp());
}

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.lightGreen,
        body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverList.list(children: [
                  SymptomTile(),
                  SymptomTile(),
                  SymptomTile(),
                ]),
                SliverGrid.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    itemBuilder: (context, index) => ActionTile())
              ],
            )),
      ),
    );
  }
}
