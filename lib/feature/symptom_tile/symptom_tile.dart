import 'package:easy_beck/common/ui/rating_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SymptomTile extends HookWidget {
  final String title;
  final List<Rating> ratings;
  final Widget image;
  final int level;
  final void Function() onExpanded;
  final void Function(int? level) onUpdated;

  const SymptomTile(
      {super.key,
      required this.ratings,
      required this.image,
      required this.onExpanded,
      required this.title,
      required this.level,
      required this.onUpdated});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox.square(
              dimension: 60,
              child: image,
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
              Text(level > 0 ? ratings[level - 1].title : "Nieokreślone"),
              SizedBox(
                height: 30,
                child: SfSliderTheme(
                  data: SfSliderThemeData(
                      thumbRadius: 8,
                      thumbColor: level > 0 ? null : Colors.grey),
                  child: SfSlider(
                      value: level,
                      interval: 1.0,
                      showTicks: false,
                      showLabels: false,
                      showDividers: true,
                      stepSize: 1,
                      onChanged: (value) {
                        onUpdated(value == 0 ? null : value.toInt());
                      },
                      min: 0.0,
                      max: ratings.length),
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
