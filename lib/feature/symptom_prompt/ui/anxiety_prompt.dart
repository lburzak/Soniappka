import 'package:easy_beck/common/ui/rating_selector.dart';
import 'package:easy_beck/feature/symptom_prompt/widget/prompt.dart';
import 'package:easy_beck/l10n/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AnxietyPrompt extends HookWidget {
  final void Function(int level) onSubmitted;

  const AnxietyPrompt({super.key, required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    final currentLevel = useState(2);

    return Prompt(
        title: context.l10n.symptomAnxiety,
        icon: SizedBox(
            width: 100, height: 100, child: Hero(tag: "icon/anxiety", child: Image.asset("assets/anxiety-new.png"))),
        body: Column(
          children: [
            Text(
              context.l10n.ratingAnxietyQuestion,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
                height: 210,
                child: RatingSelector(
                  ratings: AnxietyRatings.of(context).asList,
                  level: 2,
                  onLevelSelected: (level) {
                    currentLevel.value = level!;
                  },
                )),
          ],
        ),
        onSubmitted: () {
          onSubmitted(currentLevel.value);
        });
  }
}

class AnxietyRatings {
  final List<Rating> _ratings;

  List<Rating> get asList => _ratings;

  AnxietyRatings.of(BuildContext context) : _ratings = [
    Rating(
        title: context.l10n.ratingAnxietyTitleLevel0,
        description: context.l10n.ratingAnxietyDescriptionLevel0
    ),
    Rating(
        title: context.l10n.ratingAnxietyTitleLevel1,
        description: context.l10n.ratingAnxietyDescriptionLevel1
    ),
    Rating(
        title: context.l10n.ratingAnxietyTitleLevel2,
        description: context.l10n.ratingAnxietyDescriptionLevel2
    ),
    Rating(
        title: context.l10n.ratingAnxietyTitleLevel3,
        description: context.l10n.ratingAnxietyDescriptionLevel3
    ),
    Rating(
        title: context.l10n.ratingAnxietyTitleLevel4,
        description: context.l10n.ratingAnxietyDescriptionLevel4
    ),
  ];
}
