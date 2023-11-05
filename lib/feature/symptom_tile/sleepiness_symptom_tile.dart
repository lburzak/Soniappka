import 'package:easy_beck/common/ratings/sleepiness_ratings.dart';
import 'package:easy_beck/feature/symptom_tile/symptom_tile.dart';
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
    return SymptomTile(
      level: level.data,
      title: "Senność",
      ratings: sleepinessRatings,
      image: const Hero(
        tag: "icon/sleepiness",
        child: Image(image: AssetImage("assets/sleeping.png")),
      ),
      onExpanded: () {
        context.push("/symptom/sleepiness");
      },
      onUpdated: onUpdated,
    );
  }
}
