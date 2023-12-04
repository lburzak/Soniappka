import 'package:easy_beck/di/domain.dart';
import 'package:easy_beck/domain/common/day.dart';
import 'package:easy_beck/feature/symptom_tile/service/symptom_tile_controller.dart';
import 'package:easy_beck/feature/symptom_tile/ui/anxiety_symptom_tile.dart';
import 'package:easy_beck/feature/symptom_tile/ui/irritability_symptom_tile.dart';
import 'package:easy_beck/feature/symptom_tile/ui/sleepiness_symptom_tile.dart';
import 'package:flutter/material.dart';

class InjectedSleepinessSymptomTile extends StatefulWidget {
  final Day day;

  const InjectedSleepinessSymptomTile({super.key, required this.day});

  @override
  State<InjectedSleepinessSymptomTile> createState() =>
      _InjectedSleepinessSymptomTileState();
}

class _InjectedSleepinessSymptomTileState
    extends State<InjectedSleepinessSymptomTile> {
  late final controller = SymptomTileController(
    watchSymptomLevel: domainDependencyGraph.watchSleepinessSymptomLevel,
    setSymptomLevel: domainDependencyGraph.setSleepinessSymptomLevel,
    day: widget.day,
  );

  @override
  Widget build(BuildContext context) {
    return SleepinessSymptomTile(state: controller.state,
        onUpdated: (level) => controller.setSymptomLevel(level));
  }
}

class InjectedAnxietySymptomTile extends StatefulWidget {
  final Day day;

  const InjectedAnxietySymptomTile({super.key, required this.day});

  @override
  State<InjectedAnxietySymptomTile> createState() =>
      _InjectedAnxietySymptomTileState();
}

class _InjectedAnxietySymptomTileState
    extends State<InjectedAnxietySymptomTile> {
  late final controller = SymptomTileController(
    watchSymptomLevel: domainDependencyGraph.watchAnxietySymptomLevel,
    setSymptomLevel: domainDependencyGraph.setAnxietySymptomLevel,
    day: widget.day,
  );

  @override
  Widget build(BuildContext context) {
    return AnxietySymptomTile(state: controller.state,
        onUpdated: (level) => controller.setSymptomLevel(level));
  }
}

class InjectedIrritabilitySymptomTile extends StatefulWidget {
  final Day day;

  const InjectedIrritabilitySymptomTile({super.key, required this.day});

  @override
  State<InjectedIrritabilitySymptomTile> createState() =>
      _InjectedIrritabilitySymptomTileState();
}

class _InjectedIrritabilitySymptomTileState
    extends State<InjectedIrritabilitySymptomTile> {
  late final controller = SymptomTileController(
    watchSymptomLevel: domainDependencyGraph.watchIrritabilitySymptomLevel,
    setSymptomLevel: domainDependencyGraph.setIrritabilitySymptomLevel,
    day: widget.day,
  );

  @override
  Widget build(BuildContext context) {
    return IrritabilitySymptomTile(state: controller.state,
        onUpdated: (level) => controller.setSymptomLevel(level));
  }
}
