import 'package:collection/collection.dart';
import 'package:easy_beck/mood_tracker/domain/model/mood_log.dart';
import 'package:easy_beck/mood_tracker/domain/repository/mood_log_repository.dart';
import 'package:quiver/time.dart';

class InMemoryMoodLogRepository implements MoodLogRepository {
  final Set<MoodLog> _logs = {};
  final Clock _clock;

  InMemoryMoodLogRepository(this._clock);

  @override
  Future<MoodLog?> findCurrent() async {
    return _logs
        .where((element) => element.dateTime.isAfter(_clock.minutesAgo(5)))
        .firstOrNull;
  }

  @override
  Future<Iterable<MoodLog>> findForPeriod(DateTime start, DateTime end) async {
    return _logs.where((element) =>
        element.dateTime.isAfter(start) && element.dateTime.isBefore(end));
  }

  @override
  Future<MoodLog> upsert(MoodLog moodLog) async {
    _logs.removeWhere(
        (element) => element.dateTime.isAfter(_clock.minutesAgo(5)));
    _logs.add(moodLog);
    return moodLog;
  }
}
