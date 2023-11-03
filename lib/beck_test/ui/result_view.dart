import 'package:easy_beck/beck_test/model/depression_level.dart';
import 'package:easy_beck/l10n/localizations.dart';
import 'package:flutter/material.dart';

class ResultView extends StatelessWidget {
  final int points;
  final DepressionLevel depressionLevel;

  const ResultView(
      {super.key, required this.points, required this.depressionLevel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("$points", style: const TextStyle(fontSize: 64),),
            Text(getDepressionLevelString(context),
                style: const TextStyle(fontSize: 22))
          ],
        ),
      ),
    );
  }

  String getDepressionLevelString(BuildContext context) {
    return switch (depressionLevel) {
      DepressionLevel.none => context.l10n.depressionLevelNone,
      DepressionLevel.mild => context.l10n.depressionLevelMild,
      DepressionLevel.moderate => context.l10n.depressionLevelModerate,
      DepressionLevel.severe => context.l10n.depressionLevelSevere,
    };
  }
}
