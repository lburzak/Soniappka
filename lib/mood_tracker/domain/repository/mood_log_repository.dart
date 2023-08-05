import 'package:easy_beck/mood_tracker/domain/model/mood_log.dart';

abstract interface class MoodLogRepository {
  Future<MoodLog> upsert(MoodLog moodLog);
  Future<MoodLog?> findCurrent();
  Future<Iterable<MoodLog>> findForPeriod(DateTime start, DateTime end);
}
