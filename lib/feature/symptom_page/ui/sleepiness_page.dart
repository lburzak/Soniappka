import 'package:easy_beck/common/ui/values/asset_names.dart';
import 'package:easy_beck/common/ui/values/hero_tags.dart';
import 'package:easy_beck/common/ui/values/sleepiness_ratings.dart';
import 'package:easy_beck/feature/symptom_page/ui/symptom_page.dart';
import 'package:easy_beck/feature/symptom_page/model/symptom_page_view_model.dart';
import 'package:easy_beck/l10n/localizations.dart';
import 'package:flutter/material.dart';

class SleepinessPage extends StatelessWidget {
  final SymptomPageViewModel viewModel;

  const SleepinessPage({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SymptomPage(
        title: context.l10n.symptomSleepiness,
        description: context.l10n.ratingSleepinessQuestion,
        image: const Hero(
            tag: HeroTags.sleepinessIcon,
            child: Image(
                height: 100, image: AssetImage(AssetNames.sleepinessIcon))),
        ratings: sleepinessRatings,
        viewModel: viewModel);
  }
}
