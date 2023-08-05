import 'package:easy_beck/mood_tracker/domain/model/mood_level.dart';
import 'package:easy_beck/mood_tracker/domain/repository/mood_log_repository.dart';
import 'package:quiver/time.dart';

import '../model/mood_log.dart';

class LogMood {
  final MoodLogRepository _repository;
  final Clock _clock;

  LogMood(this._repository, this._clock);

  Future<void> call(MoodLevel level) async {
    final log = MoodLog(level: level, dateTime: _clock.now());
    _repository.upsert(log);
  }
}
