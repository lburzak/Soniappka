import 'package:easy_beck/feature/symptom_prompt/ui/irritability_prompt.dart';
import 'package:easy_beck/feature/symptom_tile/symptom_tile.dart';
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
      level: level.data ?? 0,
      title: "Drażliwość",
      ratings: irritabilityRatings,
      image: const Hero(
        tag: "icon/irritability",
        child: Image(image: AssetImage("assets/angry-cut.gif")),
      ),
      onExpanded: () {
        context.push("/symptom/irritability");
      }, onUpdated: onUpdated,
    );
  }
}
