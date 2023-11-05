import 'package:easy_beck/common/ui/widget/rating_selector.dart';
import 'package:easy_beck/l10n/localizations.dart';
import 'package:flutter/widgets.dart';

class AnxietyRatings {
  final List<Rating> _ratings;

  List<Rating> get asList => _ratings;

  AnxietyRatings.of(BuildContext context)
      : _ratings = [
    Rating(
        title: context.l10n.ratingAnxietyTitleLevel0,
        description: context.l10n.ratingAnxietyDescriptionLevel0),
    Rating(
        title: context.l10n.ratingAnxietyTitleLevel1,
        description: context.l10n.ratingAnxietyDescriptionLevel1),
    Rating(
        title: context.l10n.ratingAnxietyTitleLevel2,
        description: context.l10n.ratingAnxietyDescriptionLevel2),
    Rating(
        title: context.l10n.ratingAnxietyTitleLevel3,
        description: context.l10n.ratingAnxietyDescriptionLevel3),
    Rating(
        title: context.l10n.ratingAnxietyTitleLevel4,
        description: context.l10n.ratingAnxietyDescriptionLevel4),
  ];
}
