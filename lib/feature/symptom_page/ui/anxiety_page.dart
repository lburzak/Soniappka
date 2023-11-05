import 'package:easy_beck/common/asset_names.dart';
import 'package:easy_beck/common/hero_tags.dart';
import 'package:easy_beck/feature/symptom_page/ui/symptom_page.dart';
import 'package:easy_beck/feature/symptom_page/model/symptom_page_view_model.dart';
import 'package:easy_beck/feature/symptom_prompt/ui/anxiety_prompt.dart';
import 'package:easy_beck/l10n/localizations.dart';
import 'package:flutter/material.dart';

class AnxietyPage extends StatelessWidget {
  final SymptomPageViewModel viewModel;

  const AnxietyPage({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SymptomPage(
        title: context.l10n.symptomAnxiety,
        description: context.l10n.ratingAnxietyQuestion,
        image: const Hero(
            tag: HeroTags.anxietyIcon,
            child:
                Image(height: 100, image: AssetImage(AssetNames.anxietyIcon))),
        ratings: AnxietyRatings.of(context).asList,
        viewModel: viewModel);
  }
}
