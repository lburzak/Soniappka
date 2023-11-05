import 'package:easy_beck/common/asset_names.dart';
import 'package:easy_beck/common/hero_tags.dart';
import 'package:easy_beck/common/ratings/anxiety_ratings.dart';
import 'package:easy_beck/feature/symptom_tile/ui/symptom_tile.dart';
import 'package:easy_beck/l10n/localizations.dart';
import 'package:easy_beck/routing/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class AnxietySymptomTile extends HookWidget {
  final Stream<int?> state;
  final void Function(int? level) onUpdated;

  const AnxietySymptomTile(
      {super.key, required this.state, required this.onUpdated});

  @override
  Widget build(BuildContext context) {
    final level = useStream(state);

    return SymptomTile(
      level: level.data,
      title: context.l10n.symptomAnxiety,
      ratings: AnxietyRatings.of(context).asList,
      image: const Hero(
        tag: HeroTags.anxietyIcon,
        child: Image(image: AssetImage(AssetNames.anxietyIcon)),
      ),
      onExpanded: () {
        context.push(RouteNames.anxietyPage);
      },
      onUpdated: onUpdated,
    );
  }
}
