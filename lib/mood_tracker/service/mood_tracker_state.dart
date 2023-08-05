import 'package:easy_beck/mood_tracker/domain/model/mood_level.dart';

class MoodTrackerState {
  final MoodLevel? selectedMoodLevel;

  MoodTrackerState copyWith({
    MoodLevel? selectedMoodLevel,
  }) {
    return MoodTrackerState(
      selectedMoodLevel: selectedMoodLevel ?? this.selectedMoodLevel,
    );
  }

  const MoodTrackerState({
    this.selectedMoodLevel,
  });
}
