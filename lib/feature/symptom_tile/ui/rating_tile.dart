import 'package:easy_beck/common/ui/widget/rating_selector.dart';
import 'package:easy_beck/common/ui/widget/rating_slider.dart';
import 'package:easy_beck/l10n/localizations.dart';
import 'package:easy_beck/common/ui/theme/theme_getter.dart';
import 'package:flutter/material.dart';

class RatingTile extends StatelessWidget {
  final String title;
  final List<Rating> ratings;
  final Widget image;
  final int? level;
  final void Function() onExpanded;
  final void Function(int? level) onUpdated;

  const RatingTile(
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
        padding: const EdgeInsets.all(8),
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
                  style: context.theme.textTheme.headlineSmall,
                ),
                Text(level != null
                    ? ratings[level!].title
                    : context.l10n.ratingUndefined),
                SizedBox(
                  height: 30,
                  child: RatingSlider.compact(
                      level: level, max: 4, onChanged: onUpdated, min: 0),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: onExpanded, icon: const Icon(Icons.info)),
            )
          ],
        ),
      ),
    );
  }
}
