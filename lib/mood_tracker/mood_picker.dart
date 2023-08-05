import 'dart:async';

import 'package:easy_beck/mood_tracker/domain/model/mood_level.dart';
import 'package:easy_beck/mood_tracker/service/mood_tracker_event.dart';
import 'package:easy_beck/mood_tracker/service/mood_tracker_state.dart';
import 'package:easy_beck/mood_tracker/ui/icon_picker.dart';
import 'package:flutter/material.dart';

class MoodPicker extends StatelessWidget {
  final EventSink<MoodTrackerEvent> events;
  final Stream<MoodTrackerState> state;

  const MoodPicker({super.key, required this.events, required this.state});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MoodLevel?>(
        stream: state.map((event) => event.selectedMoodLevel),
        builder: (context, snapshot) {
          return IconPicker(
            icons:
                MoodLevel.values.map((e) => _getIconForMoodLevel(e)).toList(),
            onSelected: (iconData) {
              events.add(MoodSelected(level: _getMoodLevelForIcon(iconData)));
            },
            selectedIcon:
                snapshot.hasData ? _getIconForMoodLevel(snapshot.data!) : null,
          );
        });
  }

  IconData _getIconForMoodLevel(MoodLevel level) => switch (level) {
        MoodLevel.veryGood => Icons.sentiment_very_satisfied,
        MoodLevel.good => Icons.sentiment_satisfied,
        MoodLevel.neutral => Icons.sentiment_neutral,
        MoodLevel.bad => Icons.sentiment_dissatisfied,
        MoodLevel.veryBad => Icons.sentiment_very_dissatisfied,
      };

  MoodLevel _getMoodLevelForIcon(IconData iconData) => switch (iconData) {
        Icons.sentiment_very_satisfied => MoodLevel.veryGood,
        Icons.sentiment_satisfied => MoodLevel.good,
        Icons.sentiment_neutral => MoodLevel.neutral,
        Icons.sentiment_dissatisfied => MoodLevel.bad,
        Icons.sentiment_very_dissatisfied => MoodLevel.veryBad,
        _ => throw ArgumentError("Unsupported icon $iconData")
      };
}
