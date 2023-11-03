import 'package:easy_beck/feature/symptom_prompt/ui/anxiety_prompt.dart';
import 'package:easy_beck/feature/symptom_tile/symptom_tile.dart';
import 'package:easy_beck/l10n/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class AnxietySymptomTile extends HookWidget {
  final Stream<int?> state;
  final void Function(int? level) onUpdated;

  const AnxietySymptomTile({super.key, required this.state, required this.onUpdated});

  @override
  Widget build(BuildContext context) {
    final level = useStream(state);

    return SymptomTile(
      level: level.data,
      title: context.l10n.symptomAnxiety,
      ratings: AnxietyRatings.of(context).asList,
      image: const Hero(
        tag: "icon/anxiety",
        child: Image(image: AssetImage("assets/anxiety-new.png")),
      ),
      onExpanded: () {
        context.push("/symptom/anxiety");
      },
      onUpdated: onUpdated,
    );
  }
}
