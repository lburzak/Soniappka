import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class RatingSelector extends HookWidget {
  final List<Rating> ratings;
  final void Function(int level) onLevelSelected;

  const RatingSelector(
      {super.key, required this.ratings, required this.onLevelSelected});

  @override
  Widget build(BuildContext context) {
    final level = useState(0.0);

    return ValueListenableBuilder(
      valueListenable: level,
      builder: (context, currentLevel, _) => Column(
        children: [
          SfSlider(
              value: currentLevel,
              interval: 1.0,
              showTicks: true,
              showLabels: true,
              stepSize: 1,
              onChanged: (value) {
                level.value = value;
                onLevelSelected(value);
              },
              labelFormatterCallback: (value, text) => "${value.toInt() + 1}",
              min: 0.0,
              max: ratings.length - 1),
          const SizedBox(height: 16),
          Text(
            ratings[currentLevel.toInt()].title,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            ratings[currentLevel.toInt()].description,
          )
        ],
      ),
    );
  }
}

class Rating {
  final String title;
  final String description;

  const Rating({
    required this.title,
    required this.description,
  });
}
