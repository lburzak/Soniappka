import 'package:easy_beck/mood_tracker/domain/model/mood_level.dart';

class MoodLog {
  final MoodLevel level;
  final DateTime dateTime;

  const MoodLog({
    required this.level,
    required this.dateTime,
  });
}
