import 'package:easy_beck/common/ui/widget/rating_selector.dart';
import 'package:easy_beck/l10n/localizations.dart';
import 'package:flutter/widgets.dart';

class IrritabilityRatings {
  final List<Rating> _ratings;

  List<Rating> get asList => _ratings;
  
  IrritabilityRatings.of(BuildContext context) : _ratings = [
    Rating(
        title: context.l10n.ratingIrritabilityTitleLevel0,
        description: context.l10n.ratingIrritabilityDescriptionLevel0),
    Rating(
        title: context.l10n.ratingIrritabilityTitleLevel1,
        description: context.l10n.ratingIrritabilityDescriptionLevel1),
    Rating(
        title: context.l10n.ratingIrritabilityTitleLevel2,
        description: context.l10n.ratingIrritabilityDescriptionLevel2),
    Rating(
        title: context.l10n.ratingIrritabilityTitleLevel3,
        description: context.l10n.ratingIrritabilityDescriptionLevel3),
    Rating(
        title: context.l10n.ratingIrritabilityTitleLevel4,
        description: context.l10n.ratingIrritabilityDescriptionLevel4),
  ];
}
