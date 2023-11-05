import 'package:easy_beck/domain/beck_test/model/depression_level.dart';
import 'package:easy_beck/l10n/localizations.dart';
import 'package:easy_beck/common/ui/theme/theme_getter.dart';
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
            Text(
              "$points",
              style: context.theme.textTheme.displayLarge,
            ),
            Text(getDepressionLevelString(context),
                style: context.theme.textTheme.titleMedium)
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
