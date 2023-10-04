import 'package:easy_beck/common/ui/rating_selector.dart';
import 'package:easy_beck/common/ui/rating_slider.dart';
import 'package:flutter/material.dart';

class SymptomTile extends StatelessWidget {
  final String title;
  final List<Rating> ratings;
  final Widget image;
  final int? level;
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
      child: Padding(
        padding: EdgeInsets.all(8),
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
                Text(level != null ? ratings[level!].title : "Nieokreślone"),
                SizedBox(
                  height: 30,
                  child: RatingSlider.compact(
                      level: level, max: 4, onChanged: onUpdated, min: 0),
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
      ),
    );
  }
}
