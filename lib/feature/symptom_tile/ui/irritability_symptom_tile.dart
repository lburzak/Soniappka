import 'package:easy_beck/common/ui/values/asset_names.dart';
import 'package:easy_beck/common/ui/values/hero_tags.dart';
import 'package:easy_beck/common/ui/values/irritability_ratings.dart';
import 'package:easy_beck/feature/symptom_tile/ui/symptom_tile.dart';
import 'package:easy_beck/l10n/localizations.dart';
import 'package:easy_beck/common/routing/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class IrritabilitySymptomTile extends HookWidget {
  final Stream<int?> state;
  final void Function(int? level) onUpdated;

  const IrritabilitySymptomTile({super.key, required this.state, required this.onUpdated});

  @override
  Widget build(BuildContext context) {
    final level = useStream(state);

    return SymptomTile(
      level: level.data,
      title: context.l10n.symptomIrritability,
      ratings: irritabilityRatings,
      image: const Hero(
        tag: HeroTags.irritabilityIcon,
        child: Image(image: AssetImage(AssetNames.irritabilityIcon)),
      ),
      onExpanded: () {
        context.push(RouteNames.irritabilityPage);
      }, onUpdated: onUpdated,
    );
  }
}
