import 'package:easy_beck/mood_tracker/domain/model/mood_level.dart';

sealed class MoodTrackerEvent {
  const MoodTrackerEvent();
}

final class MoodSelected extends MoodTrackerEvent {
  final MoodLevel level;

  const MoodSelected({
    required this.level,
  }) : super();
}
