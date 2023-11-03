import 'package:easy_beck/common/ui/rating_slider.dart';
import 'package:easy_beck/l10n/localizations.dart';
import 'package:flutter/material.dart';

class RatingSelector extends StatelessWidget {
  final List<Rating> ratings;
  final int? level;
  final void Function(int? level) onLevelSelected;

  const RatingSelector(
      {super.key,
      required this.ratings,
      required this.onLevelSelected,
      this.level = 0});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RatingSlider(level: level, max: 4, onChanged: onLevelSelected, min: 0),
        const SizedBox(height: 16),
        Text(
          level != null ? ratings[level!].title : context.l10n.ratingUndefined,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 8),
        level != null ? Text(
          ratings[level!].description,
        ) : const SizedBox.shrink()
      ],
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
