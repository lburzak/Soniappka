import 'package:easy_beck/common/ui/values/asset_names.dart';
import 'package:easy_beck/common/ui/values/hero_tags.dart';
import 'package:easy_beck/common/ui/values/sleepiness_ratings.dart';
import 'package:easy_beck/feature/symptom_tile/ui/rating_tile.dart';
import 'package:easy_beck/l10n/localizations.dart';
import 'package:easy_beck/common/routing/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class SleepinessSymptomTile extends HookWidget {
  final Stream<int?> state;
  final void Function(int? level) onUpdated;

  const SleepinessSymptomTile(
      {super.key, required this.state, required this.onUpdated});

  @override
  Widget build(BuildContext context) {
    final level = useStream(state);
    return RatingTile(
      level: level.data,
      title: context.l10n.symptomSleepiness,
      ratings: SleepinessRatings.of(context).asList,
      image: const Hero(
        tag: HeroTags.sleepinessIcon,
        child: Image(image: AssetImage(AssetNames.sleepinessIcon)),
      ),
      onExpanded: () {
        context.push(RouteNames.sleepinessPage);
      },
      onUpdated: onUpdated,
    );
  }
}
