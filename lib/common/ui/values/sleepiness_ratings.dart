import 'package:easy_beck/common/ui/widget/rating_selector.dart';
import 'package:easy_beck/l10n/localizations.dart';
import 'package:flutter/cupertino.dart';

class SleepinessRatings {
  final List<Rating> _ratings;

  List<Rating> get asList => _ratings;

  SleepinessRatings.of(BuildContext context)
      : _ratings = [
          Rating(
              title: context.l10n.ratingSleepinessTitleLevel0,
              description: context.l10n.ratingSleepinessDescriptionLevel0),
          Rating(
              title: context.l10n.ratingSleepinessTitleLevel1,
              description: context.l10n.ratingSleepinessDescriptionLevel1),
          Rating(
              title: context.l10n.ratingSleepinessTitleLevel2,
              description: context.l10n.ratingSleepinessDescriptionLevel2),
          Rating(
              title: context.l10n.ratingSleepinessTitleLevel3,
              description: context.l10n.ratingSleepinessDescriptionLevel3),
          Rating(
              title: context.l10n.ratingSleepinessTitleLevel4,
              description: context.l10n.ratingSleepinessDescriptionLevel4),
        ];
}
