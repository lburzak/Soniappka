import 'package:easy_beck/common/ui/stream_visibility.dart';
import 'package:easy_beck/dashboard/dashboard_view_model.dart';
import 'package:easy_beck/feature/symptom_prompt/ui/anxiety_prompt.dart';
import 'package:easy_beck/feature/symptom_prompt/ui/irritability_prompt.dart';
import 'package:easy_beck/feature/symptom_prompt/ui/sleep_prompt.dart';
import 'package:easy_beck/feature/symptom_prompt/ui/sleepiness_prompt.dart';
import 'package:easy_beck/mood_tracker/mood_picker.dart';
import 'package:flutter/material.dart';

typedef MoodPickerBuilder = MoodPicker Function(BuildContext context);
typedef SleepPromptBuilder = SleepPrompt Function(BuildContext context);
typedef IrritabilityPromptBuilder = IrritabilityPrompt Function(
    BuildContext context);
typedef SleepinessPromptBuilder = SleepinessPrompt Function(
    BuildContext context);
typedef AnxietyPromptBuilder = AnxietyPrompt Function(BuildContext context);

class Dashboard extends StatelessWidget {
  final Stream<DashboardViewModel> viewModel;
  final MoodPickerBuilder moodPickerBuilder;
  final SleepPromptBuilder sleepPromptBuilder;
  final IrritabilityPromptBuilder irritabilityPromptBuilder;
  final SleepinessPromptBuilder sleepinessPromptBuilder;
  final AnxietyPromptBuilder anxietyPromptBuilder;

  const Dashboard(
      {super.key,
      required this.viewModel,
      required this.moodPickerBuilder,
      required this.sleepPromptBuilder,
      required this.irritabilityPromptBuilder,
      required this.sleepinessPromptBuilder,
      required this.anxietyPromptBuilder});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                StreamVisibility(
                    visibilityStream:
                        viewModel.map((event) => !event.isSleepFilled),
                    child: sleepPromptBuilder(context)),
                StreamVisibility(
                    visibilityStream:
                        viewModel.map((event) => !event.isIrritabilityFilled),
                    child: irritabilityPromptBuilder(context)),
                StreamVisibility(
                    visibilityStream:
                        viewModel.map((event) => !event.isSleepinessFilled),
                    child: sleepinessPromptBuilder(context)),
                StreamVisibility(
                    visibilityStream:
                        viewModel.map((event) => !event.isAnxietyFilled),
                    child: anxietyPromptBuilder(context))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
